
local kube = import 'external/kube_jsonnet/kube.libsonnet';
local name = std.extVar("name");
local dashboard_contents = std.extVar(name);

kube.ConfigMap("grafana-dashboard-" + name) {
  metadata+: {
    "namespace": "monitoring",
    labels+: {
      "app.kubernetes.io/component": "grafana",
	  "app.kubernetes.io/name": "grafana",
	  "app.kubernetes.io/part-of": "kube-prometheus",
	  "app.kubernetes.io/version": "8.0.2"
  }},
  data: {
    [name + ".json"]: std.toString(dashboard_contents),
  }
}

