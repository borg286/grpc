local kp = (import 'external/kube-prometheus/jsonnet/kube-prometheus/main.libsonnet')+ {
    values+:: {
      common+: {
        namespace: 'monitoring',
      },
    },
  };
{ ['node-exporter-' + name + ".json"]: kp.nodeExporter[name] for name in std.objectFields(kp.nodeExporter) } 