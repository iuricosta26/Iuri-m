# Description:
#   Tensorflow builder compatibility checker.
load(
    "//tensorflow:tensorflow.bzl",
    "py_test",
)

licenses(["notice"])

package(
    # copybara:uncomment default_applicable_licenses = ["//tensorflow:license"],
    default_visibility = [
        "//tensorflow/tools/tensorflow_builder:__subpackages__",
    ],
)

licenses(["notice"])

py_library(
    name = "compat_checker",
    srcs = ["compat_checker.py"],
    srcs_version = "PY3",
    deps = [
        "//tensorflow/python/platform:tf_logging",
        "//tensorflow/python/util:tf_decorator",
        "@six_archive//:six",
    ],
)

py_test(
    name = "compat_checker_test",
    srcs = ["compat_checker_test.py"],
    data = [
        "//tensorflow/tools/tensorflow_builder/compat_checker:test_config",
    ],
    python_version = "PY3",
    tags = ["no_pip"],
    deps = [
        ":compat_checker",
        "//tensorflow/python/platform:test",
    ],
)

filegroup(
    name = "test_config",
    srcs = ["test_config.ini"],
)
