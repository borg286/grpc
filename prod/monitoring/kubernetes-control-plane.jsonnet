local kp = (import 'external/kube-prometheus/jsonnet/kube-prometheus/main.libsonnet') + {
    values+:: {
      common+: {
        namespace: 'monitoring',
      },
    },
  };

{ ['kubernetes-control-plane-' + name + ".json"]: kp.kubernetesControlPlane[name] for name in std.objectFields(kp.kubernetesControlPlane) }