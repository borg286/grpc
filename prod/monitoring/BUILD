load("@io_bazel_rules_jsonnet//jsonnet:jsonnet.bzl", "jsonnet_to_json")

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
GRAFANA = {
    "grafana-dashboardDatasources_k8s": "grafana-dashboardDatasources.json",
    "grafana-dashboardDefinitions_k8s": "grafana-dashboardDefinitions.json",
    "grafana-dashboardSources_k8s": "grafana-dashboardSources.json",
    "grafana-deployment_k8s": "grafana-deployment.json",
    "grafana-service_k8s": "grafana-service.json",
    "grafana-serviceAccount_k8s": "grafana-serviceAccount.json",
    "grafana-serviceMonitor_k8s": "grafana-serviceMonitor.json",
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
    "prometheus-roleConfig_k8s": "prometheus-roleConfig.json",
    "prometheus-roleSpecificNamespaces_k8s": "prometheus-roleSpecificNamespaces.json",
    "prometheus-service_k8s": "prometheus-service.json",
    "prometheus-serviceAccount_k8s": "prometheus-serviceAccount.json",
    "prometheus-serviceMonitor_k8s": "prometheus-serviceMonitor.json",
}

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



jsonnet_to_json(
    name = "setup",
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

jsonnet_to_json(
    name = "prometheus",
    src = "prometheus.jsonnet",
    multiple_outputs = 1,
    outs = PROMETHEUS.values(),
    deps = common_deps,
)

jsonnet_to_json(
    name = "grafana",
    src = "grafana.jsonnet",
    multiple_outputs = 1,
    outs = GRAFANA.values(),
    deps = common_deps,
)



load("@k8s_object//:defaults.bzl", "k8s_object")



[[k8s_object(
    name = name,
    template = json,
) for name, json in group.items()]
for group in [SETUP, ALERT_MANAGER, GRAFANA, KUBE_STATE_METRICS, NODE_EXPORTER, PROMETHEUS]]


load("@io_bazel_rules_k8s//k8s:objects.bzl", "k8s_objects")

k8s_objects(
    name = "monitoring-setup",
    objects = [name for name in SETUP.keys()]
)

monitoring_k3s_targets = ALERT_MANAGER.keys() + GRAFANA.keys() + KUBE_STATE_METRICS.keys() + NODE_EXPORTER.keys() + PROMETHEUS.keys()

k8s_objects(
    name = "monitoring",
    objects = [name for name in monitoring_k3s_targets]
)