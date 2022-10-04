local kp = (import 'external/kube-prometheus/jsonnet/kube-prometheus/main.libsonnet') + {
    values+:: {
      common+: {
        namespace: 'monitoring',
      },
    },
  };

{ ['blackbox-exporter-' + name + ".json"]: kp.blackboxExporter[name] for name in std.objectFields(kp.blackboxExporter) }