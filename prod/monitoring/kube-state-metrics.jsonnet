local kp = (import 'external/kube-prometheus/jsonnet/kube-prometheus/main.libsonnet') + {
    values+:: {
      common+: {
        namespace: 'monitoring',
      },
    },
  };

{ ['kube-state-metrics-' + name + ".json"]: kp.kubeStateMetrics[name] for name in std.objectFields(kp.kubeStateMetrics) }