local kp = (import 'external/kube-prometheus/jsonnet/kube-prometheus/main.libsonnet')+ {
    values+:: {
      common+: {
        namespace: 'monitoring',
      },
    },
  };

local files ={ ['node-exporter-' + name + ".json"]: kp.nodeExporter[name] for name in std.objectFields(kp.nodeExporter) } ;

local patched = files + {
  ["node-exporter-daemonset.json"] +:{spec +:{template +:{spec +:{
      containers:[
          if container.name == "node-exporter" then container + {
            // Disable mountPropagation as we are likely running in a container
            volumeMounts:[volume+{mountPropagation:"None"} for volume in super.volumeMounts]
          }
          else container
      for container in super.containers
      ]
  }}}}
};

patched