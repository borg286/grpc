load("@io_bazel_rules_jsonnet//jsonnet:jsonnet.bzl", "jsonnet_to_json")

jsonnet_to_json(
    name = "bla",
    src = "dashboard.jsonnet",
    outs = ["dashboard.json"],
    deps = [
        "@grafonnet//:grafonnet",
    ],
)