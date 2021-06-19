local kp = (import 'external/kube-prometheus/jsonnet/kube-prometheus/main.libsonnet')+ {
    values+:: {
      common+: {
        namespace: 'monitoring',
      },
    },
  };

{ ['prometheus-' + name + ".json"]: kp.prometheus[name] for name in std.objectFields(kp.prometheus) } 
