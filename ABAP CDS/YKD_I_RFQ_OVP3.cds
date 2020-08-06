@AbapCatalog.sqlViewName: 'YWF3OVP'
@AbapCatalog.compiler.compareFilter: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Status Count'
@OData.publish : true
@UI.chart: [{
      qualifier: 'S2',
      title: 'Status Count',
      chartType: #DONUT,
      dimensions: ['status'],
      measures: ['total'],
      dimensionAttributes: [{ dimension: 'status', role: #CATEGORY }],
      measureAttributes: [{ measure: 'total', role: #AXIS_1, asDataPoint: true }]
      }]
define view
  YKD_C_OVP_WF3
  as select from swwwihead as Header
  {
    @UI.lineItem: [{position: 10, label: 'Status', qualifier: 'S1'}]
    key wi_stat as status, // Work Item Status...
    @UI.dataPoint: {title: 'Total',
            criticalityCalculation: {
            improvementDirection: #TARGET,
            deviationRangeHighValue: 2000, // Just Playing around with some numbers here...
            toleranceRangeLowValue: 50 // Just Playing around with some numbers here...
            }}
        @UI.lineItem: [{position: 20, label: 'Total', qualifier: 'S1',type: #AS_DATAPOINT}]
    count(*) as total // Counting the Totals..
  }
  where
    wi_type = 'F' // As we only want the Father Work items...
  group by
    Header.wi_stat
 