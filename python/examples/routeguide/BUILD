package(default_visibility = ["//visibility:public"])

load("@rules_proto_grpc//python:defs.bzl", "python_grpc_library")

python_grpc_library(
    name = "routeguide",
    protos = ["//proto/examples/routeguide:routeguide_proto"],
)

py_library(
    name = "resources",
    srcs = [
        "resources.py",
    ],
    deps = [
        ":routeguide",
    ],
)
