@AbapCatalog.sqlViewName: 'TKDIRFQOVP1'
@AbapCatalog.compiler.compareFilter: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'RFQ Count by Key Article'

@OData.publish: true
@UI.chart: [{
    qualifier: 'Q2',
    title: 'RFQ Count by Key Article',
    chartType: #DONUT,
    dimensions: ['article'],
    measures: ['total'],
    dimensionAttributes: [{ dimension: 'article', role: #CATEGORY }],
    measureAttributes: [{ measure: 'total', role: #AXIS_1, asDataPoint: true }]
}]
define view YKD_I_RFQ_OVP1 as select from zrfq_header as header {
    @UI.lineItem: [{ position: 10, label: 'Key Article', qualifier: 'Q1'}]
    key ref_article as article, 
    @UI.dataPoint:{
        title: 'Total RFQ',
        criticalityCalculation:{
          improvementDirection: #TARGET,
          deviationRangeHighValue: 2000, // Just Playing around with some numbers here...
          toleranceRangeLowValue: 50 // Just Playing around with some numbers here...
        }
    }
    @UI.lineItem: [{position: 20, label: 'Total RFQ', qualifier: 'Q1', type: #AS_DATAPOINT}]
    count (*) as total
} group by header.ref_article