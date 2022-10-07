load("@com_github_masmovil_bazel_rules//helm:helm.bzl", "helm_release")

package(default_visibility = ["//visibility:public"])



helm_release(
    name = "istio-gateway",
    chart = "@istio_gateway//:gateway",
    namespace = "istio-system",
    release_name = "my-istio-gateway",
    values_yaml = [":istio_values.yaml"],
)