local kp = (import 'external/kube-prometheus/jsonnet/kube-prometheus/main.libsonnet') + {
    values+:: {
      common+: {
        namespace: 'monitoring',
      },
    },
  };

{ ['alertmanager-' + name + ".json"]: kp.alertmanager[name] for name in std.objectFields(kp.alertmanager) } 