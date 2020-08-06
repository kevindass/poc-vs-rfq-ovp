@AbapCatalog.sqlViewName: 'YKDIRFQSTATUS'
@AbapCatalog.compiler.compareFilter: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'RFQ Status'
define view YKD_I_RFQ_Status as select from zrfq_header as header {
    key header.rfq_no as rfq_no,
    case
    when header.canceled_flag = 'X' and header.processed_flag = ''
    then 'CANCELLED'
    when header.canceled_flag = '' and header.processed_flag = 'X'
    then 'PROCESSED'
    else 'INPROGRESS'
    end as status
    
}