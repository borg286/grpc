package(default_visibility = ["//visibility:public"])

load("@io_bazel_rules_jsonnet//jsonnet:jsonnet.bzl", "jsonnet_to_json")

# Add in any extra dashboards you want to have on grafana
extra_dashboards = {
    "grpc-redis": "//java/com/examples/grpc_redis/server/monitoring:dashboard.json",
    "redis": "redis.json",
    #"redis": "@redis_exporter//:contrib/redis-mixin/dashboards/redis-overview.json",
}

[jsonnet_to_json(
    name = name,
    src = "dashboard-to-configmap.jsonnet",
    outs = [name + "_config_map.json"],
    ext_strs = {"name": name},
    ext_code_file_vars = [name],
    ext_code_files = [target],
    deps = ["@kube_jsonnet//:kube_lib",]
) for name, target in extra_dashboards.items()]




load("@k8s_object//:defaults.bzl", "k8s_object")
load("@io_bazel_rules_k8s//k8s:objects.bzl", "k8s_objects")

# Bundle up the json files into bash scripts that would push the configuration to kubernetes.

[k8s_object(
    name = dashboard+"_config_map",
    template = dashboard + "_config_map.json",
) for dashboard in extra_dashboards.keys()]

