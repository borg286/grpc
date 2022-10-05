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
BLACKBOX_EXPORTER = {
    "blackbox-exporter-clusterRole_k8s": "blackbox-exporter-clusterRole.json",
    "blackbox-exporter-clusterRoleBinding_k8s": "blackbox-exporter-clusterRoleBinding.json",
    "blackbox-exporter-configuration_k8s": "blackbox-exporter-configuration.json",
    "blackbox-exporter-deployment_k8s": "blackbox-exporter-deployment.json",
    "blackbox-exporter-networkPolicy_k8s": "blackbox-exporter-networkPolicy.json",
    "blackbox-exporter-service_k8s": "blackbox-exporter-service.json",
    "blackbox-exporter-serviceAccount_k8s": "blackbox-exporter-serviceAccount.json",
    "blackbox-exporter-serviceMonitor_k8s": "blackbox-exporter-serviceMonitor.json",
}
KUBE_STATE_METRICS = {
    "kube-state-metrics-clusterRole_k8s": "kube-state-metrics-clusterRole.json",
    "kube-state-metrics-clusterRoleBinding_k8s": "kube-state-metrics-clusterRoleBinding.json",
    "kube-state-metrics-deployment_k8s": "kube-state-metrics-deployment.json",
    "kube-state-metrics-prometheusRule_k8s": "kube-state-metrics-prometheusRule.json",
    "kube-state-metrics-networkPolicy_k8s": "kube-state-metrics-networkPolicy.json",
    "kube-state-metrics-service_k8s": "kube-state-metrics-service.json",
    "kube-state-metrics-serviceAccount_k8s": "kube-state-metrics-serviceAccount.json",
    "kube-state-metrics-serviceMonitor_k8s": "kube-state-metrics-serviceMonitor.json",
}
NODE_EXPORTER = {
    "node-exporter-clusterRole_k8s": "node-exporter-clusterRole.json",
    "node-exporter-clusterRoleBinding_k8s": "node-exporter-clusterRoleBinding.json",
    "node-exporter-daemonset_k8s": "node-exporter-daemonset.json",
    "node-exporter-networkPolicy_k8s": "node-exporter-networkPolicy.json",
    "node-exporter-prometheusRule_k8s": "node-exporter-prometheusRule.json",
    "node-exporter-service_k8s": "node-exporter-service.json",
    "node-exporter-serviceAccount_k8s": "node-exporter-serviceAccount.json",
    "node-exporter-serviceMonitor_k8s": "node-exporter-serviceMonitor.json",
}
PROMETHEUS = {
    "prometheus-clusterRole_k8s": "prometheus-clusterRole.json",
    "prometheus-clusterRoleBinding_k8s": "prometheus-clusterRoleBinding.json",
    "prometheus-general-serviceMonitor_k8s": "prometheus-general-serviceMonitor.json",
    "prometheus-networkPolicy_k8s": "prometheus-networkPolicy.json",
    "prometheus-podDisruptionBudget_k8s": "prometheus-podDisruptionBudget.json",
    "prometheus-prometheus_k8s": "prometheus-prometheus.json",
    "prometheus-prometheusRule_k8s": "prometheus-prometheusRule.json",
    "prometheus-roleBindingConfig_k8s": "prometheus-roleBindingConfig.json",
    "prometheus-roleBindingExtraNamespaces_k8s": "prometheus-roleBindingExtraNamespaces.json",
    "prometheus-roleBindingSpecificNamespaces_k8s": "prometheus-roleBindingSpecificNamespaces.json",
    "prometheus-roleConfig_k8s": "prometheus-roleConfig.json",
    "prometheus-roleExtraNamespaces_k8s": "prometheus-roleExtraNamespaces.json",
    "prometheus-roleSpecificNamespaces_k8s": "prometheus-roleSpecificNamespaces.json",
    "prometheus-service_k8s": "prometheus-service.json",
    "prometheus-serviceAccount_k8s": "prometheus-serviceAccount.json",
    "prometheus-serviceMonitor_k8s": "prometheus-serviceMonitor.json",
}
PROMETHEUS_ADAPTOR = {
    "prometheus-adaptor-apiService_k8s": "prometheus-adaptor-apiService.json",
    "prometheus-adaptor-clusterRole_k8s": "prometheus-adaptor-clusterRole.json",
    "prometheus-adaptor-clusterRoleAggregatedMetricsReader_k8s": "prometheus-adaptor-clusterRoleAggregatedMetricsReader.json",
    "prometheus-adaptor-clusterRoleBinding_k8s": "prometheus-adaptor-clusterRoleBinding.json",
    "prometheus-adaptor-clusterRoleBindingDelegator_k8s": "prometheus-adaptor-clusterRoleBindingDelegator.json",
    "prometheus-adaptor-clusterRoleServerResources_k8s": "prometheus-adaptor-clusterRoleServerResources.json",
    "prometheus-adaptor-configMap_k8s": "prometheus-adaptor-configMap.json",
    "prometheus-adaptor-deployment_k8s": "prometheus-adaptor-deployment.json",
    "prometheus-adaptor-networkPolicy_k8s": "prometheus-adaptor-networkPolicy.json",
    "prometheus-adaptor-podDisruptionBudget_k8s": "prometheus-adaptor-podDisruptionBudget.json",
    "prometheus-adaptor-roleBindingAuthReader_k8s": "prometheus-adaptor-roleBindingAuthReader.json",
    "prometheus-adaptor-service_k8s": "prometheus-adaptor-service.json",
    "prometheus-adaptor-serviceAccount_k8s": "prometheus-adaptor-serviceAccount.json",
    "prometheus-adaptor-serviceMonitor_k8s": "prometheus-adaptor-serviceMonitor.json",
}
KUBERNETES_CONTROL_PLANE = {
    "kubernetes-control-plane-prometheusRule_k8s": "kubernetes-control-plane-prometheusRule.json",
    "kubernetes-control-plane-serviceMonitorApiserver_k8s": "kubernetes-control-plane-serviceMonitorApiserver.json",
    "kubernetes-control-plane-serviceMonitorCoreDNS_k8s": "kubernetes-control-plane-serviceMonitorCoreDNS.json",
    "kubernetes-control-plane-serviceMonitorKubeControllerManager_k8s": "kubernetes-control-plane-serviceMonitorKubeControllerManager.json",
    "kubernetes-control-plane-serviceMonitorKubeScheduler_k8s": "kubernetes-control-plane-serviceMonitorKubeScheduler.json",
    "kubernetes-control-plane-serviceMonitorKubelet_k8s": "kubernetes-control-plane-serviceMonitorKubelet.json",

}
GRAFANA = {
    "grafana-config_k8s": "grafana-config.json",
    "grafana-dashboardDatasources_k8s": "grafana-dashboardDatasources.json",
    "grafana-dashboardDefinitions_k8s": "grafana-dashboardDefinitions.json",
    "grafana-dashboardSources_k8s": "grafana-dashboardSources.json",
    "grafana-networkPolicy_k8s": "grafana-networkPolicy.json",
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
    "@jsonnet-libs//:libsonnet",
    "@grafana//:libsonnet",
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
    name = "blackbox-exporter",
    src = "blackbox-exporter.jsonnet",
    multiple_outputs = 1,
    outs = BLACKBOX_EXPORTER.values(),
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

jsonnet_to_json(
    name = "prometheus-adaptor",
    src = "prometheus-adaptor.jsonnet",
    multiple_outputs = 1,
    outs = PROMETHEUS_ADAPTOR.values(),
    deps = common_deps,
)
jsonnet_to_json(
    name = "kubernetes-control-plane",
    src = "kubernetes-control-plane.jsonnet",
    multiple_outputs = 1,
    outs = KUBERNETES_CONTROL_PLANE.values(),
    deps = common_deps,
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
for group in [SETUP, ALERT_MANAGER, GRAFANA, KUBE_STATE_METRICS, NODE_EXPORTER, PROMETHEUS, PROMETHEUS_ADAPTOR, KUBERNETES_CONTROL_PLANE, BLACKBOX_EXPORTER]]



# Bundle everything up into a monitoring-setup, monitoring, and dashboard k8s groups.

load("@io_bazel_rules_k8s//k8s:objects.bzl", "k8s_objects")

k8s_objects(
    name = "setup",
    objects = [name for name in SETUP.keys()]
)

monitoring_k3s_targets = ALERT_MANAGER.keys() + KUBE_STATE_METRICS.keys() + NODE_EXPORTER.keys() + PROMETHEUS.keys() + PROMETHEUS_ADAPTOR.keys() + KUBERNETES_CONTROL_PLANE.keys() + BLACKBOX_EXPORTER.keys()

k8s_objects(
    name = "monitoring",
    objects = [name for name in monitoring_k3s_targets]
)

k8s_objects(
    name = "dashboards",
    objects = [name for name in GRAFANA.keys()] + ["//prod/monitoring/dashboard_targets:" + name + "_config_map" for name in extra_dashboard_names]
)