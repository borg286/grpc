
local kube = import 'external/kube_jsonnet/kube.libsonnet';
local envs = import 'prod/envs.libsonnet';
local params = std.extVar("params");

kube.Service(params.name) {
  metadata+:{namespace:envs.getName(params.env), labels +:{prometheus:"main"} },
  spec: {
    selector: {"name": params.name},
    ports: [
      {
        name: "main",
        port: std.parseInt(params.port),
        targetPort: std.parseInt(params.port),
      },
      {
        name: "http",
        port: 1234,
        targetPort: 1234,
      },
    ],
    type: "ClusterIP",
    //clusterIP: null,
  },
}

