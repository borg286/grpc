local kp = (import 'external/kube-prometheus/jsonnet/kube-prometheus/main.libsonnet') + {
    values+:: {
      common+: {
        namespace: 'monitoring',
      },
    },
  };


{ ['00namespace-' + name + ".json"]: kp.kubePrometheus[name] for name in std.objectFields(kp.kubePrometheus) } +
{ ['0prometheus-operator-' + name + ".json"]: kp.prometheusOperator[name] for name in std.objectFields(kp.prometheusOperator) } 