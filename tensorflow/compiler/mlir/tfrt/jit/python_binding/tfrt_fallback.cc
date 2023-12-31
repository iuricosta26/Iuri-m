/* Copyright 2022 The TensorFlow Authors. All Rights Reserved.

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
==============================================================================*/

#include "tensorflow/compiler/mlir/tfrt/jit/python_binding/tfrt_fallback.h"

#include <string>
#include <utility>
#include <vector>

#include "llvm/ADT/SmallVector.h"
#include "pybind11/numpy.h"  // from @pybind11
#include "pybind11/pybind11.h"  // from @pybind11
#include "pybind11/stl.h"  // from @pybind11
#include "tensorflow/compiler/mlir/tfrt/jit/python_binding/conversion_utils.h"
#include "tensorflow/compiler/mlir/tfrt/jit/tf_jitrt.h"
#include "tensorflow/compiler/mlir/tfrt/runtime_fallback/runtime_fallback_executor.h"
#include "tensorflow/compiler/xla/primitive_util.h"
#include "tensorflow/core/framework/tensor.h"
#include "tensorflow/core/framework/tensor_shape.h"
#include "tensorflow/core/platform/refcount.h"
#include "tensorflow/core/runtime_fallback/util/type_util.h"
#include "tfrt/dtype/dtype.h"  // from @tf_runtime

namespace tensorflow {

namespace py = pybind11;

using ::xla::runtime::MemrefDesc;

static py::array ConvertTensorToPyArray(const Tensor& tensor) {
  auto tensor_sizes = tensor.shape().dim_sizes();

  auto dtype = tfd::GetTfrtDtype(tensor.dtype());
  std::vector<ssize_t> sizes(tensor_sizes.begin(), tensor_sizes.end());
  std::vector<ssize_t> strides(tensor_sizes.size(), tfrt::GetHostSize(dtype));
  if (strides.size() > 1) {
    for (size_t d = strides.size() - 1; d > 0; --d) {
      strides[d - 1] = strides[d] * tensor_sizes[d];
    }
  }

  return py::array(py::buffer_info(tensor.data(), tfrt::GetHostSize(dtype),
                                   ToPythonStructFormat(dtype), strides.size(),
                                   sizes, strides));
}

std::vector<py::array> RunTfrtFallback(
    const std::string& module_ir, const std::string& entrypoint,
    const std::vector<py::array>& arguments) {
  // Convert arguments to memrefs.
  std::vector<MemrefDesc> memrefs;
  memrefs.reserve(arguments.size());
  for (size_t i = 0; i < arguments.size(); ++i) {
    memrefs.emplace_back(ConvertPyArrayMemrefDesc(arguments[i]));
  }

  // Convert memrefs to tensors.
  llvm::SmallVector<Tensor> tensor_arguments;
  tensor_arguments.reserve(arguments.size());
  for (const auto& memref : memrefs) {
    size_t size = xla::primitive_util::ByteWidth(memref.dtype());
    // memref.data is still owned by the py::array. Therefore we pass nullptr as
    // base_ptr, because we don't need to keep track of it for deallocation.
    // The tensor will take ownership of the buffer from the reference counted
    // pointer.
    auto* buffer = new MemrefTensorBuffer(/*base_ptr=*/nullptr, memref.data(),
                                          size, /*owner=*/false);
    auto ptr = core::RefCountPtr<MemrefTensorBuffer>(buffer);
    TensorShape shape;
    auto st = TensorShapeUtils::MakeShape(memref.sizes(), &shape);
    (void)st;

    DataType dtype = [&]() {
      switch (memref.dtype()) {
        case xla::PrimitiveType::PRED:
          return DT_BOOL;
        case xla::PrimitiveType::F32:
          return DT_FLOAT;
        case xla::PrimitiveType::F64:
          return DT_DOUBLE;
        case xla::PrimitiveType::S8:
          return DT_INT8;
        case xla::PrimitiveType::S16:
          return DT_INT16;
        case xla::PrimitiveType::S32:
          return DT_INT32;
        case xla::PrimitiveType::S64:
          return DT_INT64;
        case xla::PrimitiveType::U8:
          return DT_UINT8;
        case xla::PrimitiveType::U16:
          return DT_UINT16;
        case xla::PrimitiveType::U32:
          return DT_UINT32;
        case xla::PrimitiveType::U64:
          return DT_UINT64;
        case xla::PrimitiveType::C64:
          return DT_COMPLEX64;
        case xla::PrimitiveType::C128:
          return DT_COMPLEX128;
        default:
          LOG(FATAL) << "Unsupported data type: "  // Crash OK
                     << memref.dtype();
      }
    }();

    tensor_arguments.emplace_back(dtype, std::move(shape), std::move(ptr));
  }

  RuntimeFallbackExecutor executor(/*num_threads=*/4);
  executor.Prepare(module_ir);
  auto results = executor.Execute(entrypoint, tensor_arguments);
  std::vector<py::array> ret_values;
  ret_values.reserve(results.size());
  for (const auto& tensor : results) {
    ret_values.push_back(ConvertTensorToPyArray(tensor));
  }
  return ret_values;
}

PYBIND11_MODULE(_tfrt_fallback, m) {
  m.def("run_tfrt_fallback", &RunTfrtFallback);
}

}  // namespace tensorflow
