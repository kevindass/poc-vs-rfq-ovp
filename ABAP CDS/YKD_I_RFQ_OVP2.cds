@AbapCatalog.sqlViewName: 'YKDIRFQOVP2'
@AbapCatalog.compiler.compareFilter: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'RFQ Submitted'

@OData.publish : true
define view YKD_I_RFQ_OVP2 as select from zrfq_header as header {
 @UI.lineItem: [{position: 10, label: 'RFQ #' }]
 key header.rfq_no,
 @UI.lineItem: [{position: 20, label: 'Text' }]
 header.descr,
 @UI.lineItem: [{position: 30, label: 'Submitted' }]
 header.quote_status_dt
 //header.erdat
}where header.quote_status = 'S'