local kp = (import 'external/kube-prometheus/jsonnet/kube-prometheus/main.libsonnet') + {
  values+:: {
    common+:: {
      namespace: 'monitoring',
    },
  },
};

local files = { ['grafana-' + name + ".json"]: kp.grafana[name] for name in std.objectFields(kp.grafana) };

local patched = files + {
        ["grafana-deployment.json"] +:{spec +:{template +:{spec +:{containers:[
            if container.name == "grafana" then container + {env +:[
              {name: "GF_AUTH_BASIC_ENABLED",value : "false"},
              {name: "GF_AUTH_ANONYMOUS_ENABLED",value : "true"},
              {name: "GF_AUTH_ANONYMOUS_ORG_ROLE",value : "Admin"},
              {name: "GF_SERVER_ROOT_URL",value : "/"},
            ]}
            else container
            for container in super.containers
        ]}}}}
};


patched