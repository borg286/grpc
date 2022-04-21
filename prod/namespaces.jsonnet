local kube = import "external/kube_jsonnet/kube.libsonnet";
local user = std.extVar("user");
local envs = import "prod/envs.libsonnet";
{
  "prod.json": kube.Namespace(envs.prod.name){metadata+:{labels+:{["app.kubernetes.io/name"]:"notbob"}}},
  "staging.json": kube.Namespace(envs.staging.name){metadata+:{labels+:{["app.kubernetes.io/name"]:"notbob"}}},
  "dev.json": kube.Namespace(envs.dev.name){metadata+:{labels+:{["app.kubernetes.io/name"]:"notbob"}}},
  "myns.json": kube.Namespace(user){metadata+:{labels+:{["app.kubernetes.io/name"]:"notbob"}}},
}
