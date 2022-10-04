local kp = (import 'external/kube-prometheus/jsonnet/kube-prometheus/main.libsonnet') + {
    values+:: {
      common+: {
        namespace: 'monitoring',
      },
    },
  };

{ ['prometheus-adaptor-' + name + ".json"]: kp.prometheusAdapter[name] for name in std.objectFields(kp.prometheusAdapter) }