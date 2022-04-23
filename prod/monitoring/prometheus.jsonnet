local envs = import 'prod/envs.libsonnet';

local kp = (import 'external/kube-prometheus/jsonnet/kube-prometheus/main.libsonnet')+ {
    values+:: {
      common+: {
        namespace: 'monitoring',
      },
    },
  };


local files = { ['prometheus-' + name + ".json"]: kp.prometheus[name] for name in std.objectFields(kp.prometheus) };

local standardRoleBinds = kp.prometheus["roleBindingSpecificNamespaces"];
local standardRoles = kp.prometheus["roleSpecificNamespaces"];
local namespaces = [envs.prod.name, envs.staging.name, envs.dev.name, envs.myns.name];

local general_servicemonitor = kp.prometheus["serviceMonitor"] {
  metadata :{
    labels:{
      // This needs to match the serviceMonitorSelector below
      ["app.kubernetes.io/name"]: "notbob",
    },
    name: "mrmath-servicemontitor",
    namespace: "mrmath",
  },
  spec+:{
    endpoints:[{
      // This needs to match the port names exported by pods.
      port:"http",
      interval: "15s"
    }],
    // This needs to match the label in services that want to be monitored
    selector:{matchLabels:{prometheus:"main"}}
  }
};

local patched = files +{
        ["prometheus-general-serviceMonitor.json"]: general_servicemonitor,
        // Match on the k8s-provided metadata entry to match all namespaces.
        ["prometheus-prometheus.json"] +:{spec +:{serviceMonitorNamespaceSelector:{
          matchExpressions:[{
            key:"kubernetes.io/metadata.name",
            operator: "Exists"}]
          },
          serviceMonitorSelector:{
          }}},
        // Use the roleBindingSpecificNamespaces's first entry as a template to let prometheus' service account access
        // to all other namespaces
        ["prometheus-roleBindingExtraNamespaces.json"]: standardRoleBinds{items:[standardRoleBinds.items[0]+{metadata+:{namespace:namespace}} for namespace in namespaces]},
        ["prometheus-roleExtraNamespaces.json"]: standardRoles{items:[standardRoles.items[0]+{metadata+:{namespace:namespace}} for namespace in namespaces]},
};


patched