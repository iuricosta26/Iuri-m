# Description:
#   Contains the Keras initializer API (internal TensorFlow version).

package(
    # copybara:uncomment default_applicable_licenses = ["//tensorflow:license"],
    default_visibility = ["//tensorflow/python/keras:__subpackages__"],
    licenses = ["notice"],
)

filegroup(
    name = "all_py_srcs",
    srcs = glob(["*.py"]),
    visibility = [
        "//tensorflow/python/keras/google/private_tf_api_test:__pkg__",
    ],
)

py_library(
    name = "initializers",
    srcs = [
        "__init__.py",
        "initializers_v1.py",
        "initializers_v2.py",
    ],
    srcs_version = "PY3",
    deps = [
        "//tensorflow/python:tf2",
        "//tensorflow/python/framework:constant_op",
        "//tensorflow/python/framework:dtypes",
        "//tensorflow/python/keras:backend",
        "//tensorflow/python/keras/utils:generic_utils",
        "//tensorflow/python/keras/utils:tf_inspect",
        "//tensorflow/python/ops:array_ops",
        "//tensorflow/python/ops:init_ops",
        "//tensorflow/python/ops:linalg_ops",
        "//tensorflow/python/ops:math_ops",
        "//tensorflow/python/ops:random_ops",
        "//tensorflow/python/ops:stateless_random_ops",
        "//tensorflow/python/util:tf_export",
    ],
)
