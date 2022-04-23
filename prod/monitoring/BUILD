load("@io_bazel_rules_jsonnet//jsonnet:jsonnet.bzl", "jsonnet_to_json")

# Segregate all the prometheus operator kubernetes definitions into groups so changes in one stack don't mean
# the entire setup needs to be rebuilt.  The keys are the build rules that can push individual configuration to kubernetes.
SETUP = {
    "00namespace-namespace_k8s": "00namespace-namespace.json",
    "0prometheus-operator-0alertmanagerConfigCustomResourceDefinition_k8s": "0prometheus-operator-0alertmanagerConfigCustomResourceDefinition.json",
    "0prometheus-operator-0alertmanagerCustomResourceDefinition_k8s": "0prometheus-operator-0alertmanagerCustomResourceDefinition.json",
    "0prometheus-operator-0podmonitorCustomResourceDefinition_k8s": "0prometheus-operator-0podmonitorCustomResourceDefinition.json",
    "0prometheus-operator-0probeCustomResourceDefinition_k8s": "0prometheus-operator-0probeCustomResourceDefinition.json",
    "0prometheus-operator-0prometheusCustomResourceDefinition_k8s": "0prometheus-operator-0prometheusCustomResourceDefinition.json",
    "0prometheus-operator-0prometheusruleCustomResourceDefinition_k8s": "0prometheus-operator-0prometheusruleCustomResourceDefinition.json",
    "0prometheus-operator-0servicemonitorCustomResourceDefinition_k8s": "0prometheus-operator-0servicemonitorCustomResourceDefinition.json",
    "0prometheus-operator-0thanosrulerCustomResourceDefinition_k8s": "0prometheus-operator-0thanosrulerCustomResourceDefinition.json",
    "0prometheus-operator-clusterRole_k8s": "0prometheus-operator-clusterRole.json",
    "0prometheus-operator-clusterRoleBinding_k8s": "0prometheus-operator-clusterRoleBinding.json",
    "0prometheus-operator-deployment_k8s": "0prometheus-operator-deployment.json",
    "0prometheus-operator-prometheusRule_k8s": "0prometheus-operator-prometheusRule.json",
    "0prometheus-operator-service_k8s": "0prometheus-operator-service.json",
    "0prometheus-operator-serviceAccount_k8s": "0prometheus-operator-serviceAccount.json",
    "prometheus-operator-serviceMonitor_k8s": "0prometheus-operator-serviceMonitor.json",
    "namespace-prometheusRule_k8s": "00namespace-prometheusRule.json",
}
ALERT_MANAGER = {
    "alertmanager-alertmanager_k8s": "alertmanager-alertmanager.json",
    "alertmanager-podDisruptionBudget_k8s": "alertmanager-podDisruptionBudget.json",
    "alertmanager-prometheusRule_k8s": "alertmanager-prometheusRule.json",
    "alertmanager-secret_k8s": "alertmanager-secret.json",
    "alertmanager-service_k8s": "alertmanager-service.json",
    "alertmanager-serviceAccount_k8s": "alertmanager-serviceAccount.json",
    "alertmanager-serviceMonitor_k8s": "alertmanager-serviceMonitor.json",
}
KUBE_STATE_METRICS = {
    "kube-state-metrics-clusterRole_k8s": "kube-state-metrics-clusterRole.json",
    "kube-state-metrics-clusterRoleBinding_k8s": "kube-state-metrics-clusterRoleBinding.json",
    "kube-state-metrics-deployment_k8s": "kube-state-metrics-deployment.json",
    "kube-state-metrics-prometheusRule_k8s": "kube-state-metrics-prometheusRule.json",
    "kube-state-metrics-service_k8s": "kube-state-metrics-service.json",
    "kube-state-metrics-serviceAccount_k8s": "kube-state-metrics-serviceAccount.json",
    "kube-state-metrics-serviceMonitor_k8s": "kube-state-metrics-serviceMonitor.json",
}
NODE_EXPORTER = {
    "node-exporter-clusterRole_k8s": "node-exporter-clusterRole.json",
    "node-exporter-clusterRoleBinding_k8s": "node-exporter-clusterRoleBinding.json",
    "node-exporter-daemonset_k8s": "node-exporter-daemonset.json",
    "node-exporter-prometheusRule_k8s": "node-exporter-prometheusRule.json",
    "node-exporter-service_k8s": "node-exporter-service.json",
    "node-exporter-serviceAccount_k8s": "node-exporter-serviceAccount.json",
    "node-exporter-serviceMonitor_k8s": "node-exporter-serviceMonitor.json",
}
PROMETHEUS = {
    "prometheus-clusterRole_k8s": "prometheus-clusterRole.json",
    "prometheus-clusterRoleBinding_k8s": "prometheus-clusterRoleBinding.json",
    "prometheus-podDisruptionBudget_k8s": "prometheus-podDisruptionBudget.json",
    "prometheus-prometheus_k8s": "prometheus-prometheus.json",
    "prometheus-prometheusRule_k8s": "prometheus-prometheusRule.json",
    "prometheus-roleBindingConfig_k8s": "prometheus-roleBindingConfig.json",
    "prometheus-roleBindingSpecificNamespaces_k8s": "prometheus-roleBindingSpecificNamespaces.json",
    "prometheus-roleBindingExtraNamespaces_k8s": "prometheus-roleBindingExtraNamespaces.json",
    "prometheus-roleConfig_k8s": "prometheus-roleConfig.json",
    "prometheus-roleSpecificNamespaces_k8s": "prometheus-roleSpecificNamespaces.json",
    "prometheus-roleExtraNamespaces_k8s": "prometheus-roleExtraNamespaces.json",
    "prometheus-service_k8s": "prometheus-service.json",
    "prometheus-serviceAccount_k8s": "prometheus-serviceAccount.json",
    "prometheus-serviceMonitor_k8s": "prometheus-serviceMonitor.json",
    "promethdus-general-serviceMonitor_k8s": "prometheus-general-serviceMonitor.json",
}
GRAFANA = {
    "grafana-dashboardDatasources_k8s": "grafana-dashboardDatasources.json",
    "grafana-dashboardDefinitions_k8s": "grafana-dashboardDefinitions.json",
    "grafana-dashboardSources_k8s": "grafana-dashboardSources.json",
    "grafana-deployment_k8s": "grafana-deployment.json",
    "grafana-service_k8s": "grafana-service.json",
    "grafana-serviceAccount_k8s": "grafana-serviceAccount.json",
    "grafana-serviceMonitor_k8s": "grafana-serviceMonitor.json",
}

# Since bazel doesn't allow dynamic importing of arbitrary dependencies, we must declare them in the
# workspace file, and import them here.
common_deps = [
    "@kube-prometheus//:libsonnet",
    "@prometheus-operator//:libsonnet",
    "@kube-state-metrics//:libsonnet",
    "@kubernetes-mixin//:libsonnet",
    "@alertmanager//:libsonnet",
    "@kubernetes-grafana//:libsonnet",
    "@node_exporter//:libsonnet",
    "@prometheus//:libsonnet",
    "@grafonnet-lib//:libsonnet",
    "@jsonnet-libs//:libsonnet"
]


# The jsonnet files import from kube-prometheus's main.jsonnet and then pull out the various
# stacks like the alert manager, node-exporter, grafana, custom resource definitions...
# jsonnet_to_json executes these jsonnet files to produce a set of json files.
jsonnet_to_json(
    name = "setup-json",
    src = "setup.jsonnet",
    multiple_outputs = 1,
    outs = SETUP.values(),
    deps = common_deps,
)

jsonnet_to_json(
    name = "node-exporter",
    src = "node-exporter.jsonnet",
    multiple_outputs = 1,
    outs = NODE_EXPORTER.values(),
    deps = common_deps,
)

jsonnet_to_json(
    name = "kube-state-metrics",
    src = "kube-state-metrics.jsonnet",
    multiple_outputs = 1,
    outs = KUBE_STATE_METRICS.values(),
    deps = common_deps,
)

jsonnet_to_json(
    name = "alertmanager",
    src = "alertmanager.jsonnet",
    multiple_outputs = 1,
    outs = ALERT_MANAGER.values(),
    deps = common_deps,
)

load("//prod:cluster_consts.bzl", "ENVS")

jsonnet_to_json(
    name = "prometheus",
    src = "prometheus.jsonnet",
    multiple_outputs = 1,
    outs = PROMETHEUS.values(),
    deps = common_deps + ["//prod:envs"],
)

# Add in any extra dashboards you want to have on grafana
# in dashboard_targets' BUILD file route the build targets to the dashboards.
# we only list the names to keep build time short.
extra_dashboard_names = [
    "grpc-redis",
    "redis"
]
jsonnet_to_json(
    name = "grafana",
    src = "grafana.jsonnet",
    multiple_outputs = 1,
    outs = GRAFANA.values(),
    ext_code = {"dashboard_names": "%s" % extra_dashboard_names},
    deps = common_deps,
)




load("@k8s_object//:defaults.bzl", "k8s_object")

# Bundle up the json files into bash scripts that would push the configuration to kubernetes.

[[k8s_object(
    name = name,
    template = json,
) for name, json in group.items()]
for group in [SETUP, ALERT_MANAGER, GRAFANA, KUBE_STATE_METRICS, NODE_EXPORTER, PROMETHEUS]]



# Bundle everything up into a monitoring-setup, monitoring, and dashboard k8s groups.

load("@io_bazel_rules_k8s//k8s:objects.bzl", "k8s_objects")

k8s_objects(
    name = "setup",
    objects = [name for name in SETUP.keys()]
)

monitoring_k3s_targets = ALERT_MANAGER.keys() + KUBE_STATE_METRICS.keys() + NODE_EXPORTER.keys() + PROMETHEUS.keys()

k8s_objects(
    name = "monitoring",
    objects = [name for name in monitoring_k3s_targets]
)

k8s_objects(
    name = "dashboards",
    objects = [name for name in GRAFANA.keys()] + ["//prod/monitoring/dashboard_targets:" + name + "_config_map" for name in extra_dashboard_names]
)