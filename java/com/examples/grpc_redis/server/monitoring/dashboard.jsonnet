
local grafana = import 'external/grafonnet/_gen/7.0/jsonnet/grafana.libsonnet';

local dashboard = grafana.dashboard;
local row = grafana.row;
local prometheus = grafana.prometheus;
local template = grafana.template;
local graphPanel = grafana.graphPanel;

{
  'my-dashboard.json':
    dashboard.new('My Dashboard')
    .addTemplate(
      {
        current: {
          text: 'Prometheus',
          value: 'Prometheus',
        },
        hide: 0,
        label: null,
        name: 'datasource',
        options: [],
        query: 'prometheus',
        refresh: 1,
        regex: '',
        type: 'datasource',
      },
    )
}