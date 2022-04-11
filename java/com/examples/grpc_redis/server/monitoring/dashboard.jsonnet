local grafana = import 'external/grafonnet-lib/grafonnet/grafana.libsonnet';
local g = import'external/jsonnet-libs/grafana-builder/grafana.libsonnet';
local template = grafana.template;

local dashboard = grafana.dashboard;
local singlestat = grafana.singlestat;
local graphPanel = grafana.graphPanel;
local prometheus = grafana.prometheus;
 
 
local clusterTemplate =
  template.new(
    name='brian',
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
  'My Test Dashboard wahoo',
)
.addRow(
  g.row('CPU Usage')
  .addPanel(
    g.panel('Something') +
    g.queryPanel('kube_pod_container_info{namespace="mrmath"}', 'something') + 
    g.stack
  )
)
