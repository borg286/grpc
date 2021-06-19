package(default_visibility = ["//prod/monitoring:__subpackages__"])

load("@io_bazel_rules_jsonnet//jsonnet:jsonnet.bzl", "jsonnet_to_json")

jsonnet_to_json(
    name = "dashboard",
    src = "dashboard.jsonnet",
    outs = ["dashboard.json"],
    deps = [
        "@grafonnet//:libsonnet",
    ],
)