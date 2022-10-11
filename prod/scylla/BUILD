load("@com_github_masmovil_bazel_rules//helm:helm.bzl", "helm_release")

package(default_visibility = ["//visibility:public"])



helm_release(
    name = "operator",
    chart = "@scylla_operator//:operator",
    namespace = "scylla-operator",
    release_name = "scyla-operator",
    values_yaml = [":scylla_operator_values.yaml"],
)
helm_release(
    name = "scylla",
    chart = "@scylla//:scylla",
    namespace = "should-probably-be-application-specific",
    release_name = "should-probably-be-application-specific",
    values_yaml = [":scylla_values.yaml"],
)
helm_release(
    name = "manager",
    chart = "@scylla_manager//:manager",
    namespace = "scylla-manager",
    release_name = "scyla-manager",
    values_yaml = [":scylla_manager_values.yaml"],
)