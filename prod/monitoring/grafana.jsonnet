local dashboards = std.extVar("dashboard_names");

// Update anything we want about grafana using its API, namely adding in extra dashboards
local kp = (import 'external/kube-prometheus/jsonnet/kube-prometheus/main.libsonnet') + {
  values+:: {
    common+:: {
      namespace: 'monitoring',
    },
  }
};

// Render it to json
local files = { ['grafana-' + name + ".json"]: kp.grafana[name] for name in std.objectFields(kp.grafana) };

local Mount(name) = {
  mountPath:"/grafana-dashboard-definitions/0/" + name,
  name: "grafana-dashboard-" + name,
  readOnly: false,
};

local ConfigMap(name) = {
  configMap:{
    name: "grafana-dashboard-" + name,
  },
  name: "grafana-dashboard-" + name,
};


// Tweak the json so it has environment variables that disable authentication, and thus make quick prototyping faster.
local patched = files + {
        ["grafana-deployment.json"] +:{spec +:{template +:{spec +:{
          containers:[
              if container.name == "grafana" then container + {
                env +:[
                  {name: "GF_AUTH_BASIC_ENABLED",value : "false"},
                  {name: "GF_AUTH_ANONYMOUS_ENABLED",value : "true"},
                  {name: "GF_AUTH_ANONYMOUS_ORG_ROLE",value : "Admin"},
                  {name: "GF_SERVER_ROOT_URL",value : "/"},
                ],
                volumeMounts +:[ Mount(dashboard) for dashboard in dashboards],
              }
              else container
              for container in super.containers
          ],
          volumes +:[ConfigMap(dashboard) for dashboard in dashboards],
        }}}}
};

// Finally make this patched map of grafana files the main map we output. Keys in this map are interpreted as names of files mapping to the json that should go in them.
patched