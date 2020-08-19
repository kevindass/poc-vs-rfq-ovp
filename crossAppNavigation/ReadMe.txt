-----------------------------------------------------------------------
add below code in Target App Component.js
-----------------------------------------------------------------------

"sap/ui/generic/app/navigation/service/NavigationHandler"

// Navigation from OVP
	var oNavigationHandler = new NavigationHandler(this);
	var oParseNavigationPromise = oNavigationHandler.parseNavigation();

	oParseNavigationPromise.done(function (oAppData, oStartupParameters, sNavType) {
				
	var oAppDataModel = new JSONModel(oAppData.oSelectionVariant._mSelectOptions);
		this.setModel(oAppDataModel, "appDataOVP");
	}.bind(this));
	
-----------------------------------------------------------------------
Add below in Master.controller.js
-----------------------------------------------------------------------		
		/**
		 * If the master route was hit (empty hash) we have to set
		 * the hash to to the first item in the list as soon as the
		 * listLoading is done and the first item in the list is known
		 * @private
		 */
		_onMasterMatched: function () {
			this.getOwnerComponent().oListSelector.oWhenListLoadingIsDone.then(
				function (mParams) {
					if (mParams.list.getMode() === "None") {
						return;
					}
					var sObjectId;
					// Navigation from OVP
					var ovpContext = this.getModel("appDataOVP");
					if(ovpContext !== undefined){
						sObjectId = ovpContext.getData().rfq_no[0].Low;  //get Selection Variant
					}else{
						sObjectId = mParams.firstListitem.getBindingContext().getProperty("RfqNo");
					}
				
					this._oApplicationProperties.setProperty("/selectedRFQNo", sObjectId);
					this.getRouter().navTo("object", {
						objectId: sObjectId
					}, true);
				}.bind(this),
				function (mParams) {
					if (mParams.error) {
						return;
					}
					this.getRouter().getTargets().display("detailNoObjectsAvailable");
				}.bind(this)
			);
		},