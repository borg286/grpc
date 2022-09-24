load("@io_bazel_rules_docker//python3:image.bzl", "py3_image")
load("@my_pip_install//:requirements.bzl", "requirement")

py3_image(
	name = "main",
    srcs = ["main.py"],
    main = "main.py",
    srcs_version = "PY3",
    visibility = ["//visibility:public"],
    deps = [requirement("requests")]
)