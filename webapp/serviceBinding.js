function initModel() {
	var sUrl = "/sap/opu/odata/sap/YKD_I_RFQ_OVP3_CDS/";
	var oModel = new sap.ui.model.odata.ODataModel(sUrl, true);
	sap.ui.getCore().setModel(oModel);
}