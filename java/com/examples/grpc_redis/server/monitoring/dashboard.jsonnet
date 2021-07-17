local grafana = import 'external/grafonnet-lib/grafonnet/grafana.libsonnet';
local g = import'external/jsonnet-libs/grafana-builder/grafana.libsonnet';
local template = grafana.template;

local dashboard = grafana.dashboard;
local singlestat = grafana.singlestat;
local graphPanel = grafana.graphPanel;
local prometheus = grafana.prometheus;


local clusterTemplate =
  template.new(
    name='cluster',
    datasource='$datasource',
    query='',
    current='',
    hide='',
    refresh=2,
    includeAll=false,
    sort=1
  );

local namespaceTemplate =
  template.new(
    name='namespace',
    datasource='$datasource',
    query='label_values(kube_pod_info{%(clusterLabel)s=""}, namespace)',
    current='',
    hide='',
    refresh=2,
    includeAll=false,
    sort=1
  );

local podTemplate =
  template.new(
    name='pod',
    datasource='$datasource',
    query='label_values(kube_pod_info{%(clusterLabel)s="", namespace="$namespace"}, pod)',
    current='',
    hide='',
    refresh=2,
    includeAll=false,
    sort=1
  );


g.dashboard(
  'My Test Dashboard',
)
.addRow(
  g.row('CPU Usage')
  .addPanel(
    g.panel('CPU Usage')
  )
)
