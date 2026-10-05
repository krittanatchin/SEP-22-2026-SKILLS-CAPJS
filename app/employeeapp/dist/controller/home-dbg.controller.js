sap.ui.define([
    "sap/ui/core/mvc/Controller",
    "sap/ui/model/Filter",
    "sap/ui/model/FilterOperator",
    "sap/m/MessageBox"
], (Controller,Filter,FilterOperator,MessageBox) => {
    "use strict";

    return Controller.extend("employeeapp.controller.home", {
        onInit() {
        },

        onSearch: function(oEvent){
            var sQuery = oEvent.getParameter("query") || oEvent.getParameter("newValue");
            var aFilter = [];

            if(sQuery && sQuery.length >0){
                aFilter.push(new Filter("nameFirst", FilterOperator.Contains, sQuery));
            }
            var oTable = this.getView().byId("idEmployeeTab");
            var oBinding = oTable.getBinding("items");
            oBinding.filter(aFilter);
        },

        onCreate: function(oEvent){
            if(!this.oEmpDialogAdd){
                this.oEmpDialogAdd = this .loadFragment({
                    name: "employeeapp.fragments.CreateEmployeeDialog"
                })
            }
            this.oEmpDialogAdd.then(function(oDialog){
                this.oDialog = oDialog;
                this.oDialog.open();
            }.bind(this));
        },
        _closeDialog: function(){
            this.oDialog.close();
        },

        _createEmployee: function (oEvent) {
            var vEmpID, vFirstName, vLastName, vMiddleName, vNameInitials, vGender, vLanguage, vPhoneNo, vLoginName, vEmail, vCurrency, vSalary, vAccNo, vBankID, vBankName;
 
            vEmpID = crypto.randomUUID();
            vFirstName = this.getView().byId("idIPEmpFNM").getValue();
            vLastName = this.getView().byId("idIPEmpLNM").getValue();
            vMiddleName = this.getView().byId("idIPEmpMNM").getValue();
            vNameInitials = this.getView().byId("idIPEmpNI").getValue();
            vGender = this.getView().byId("idGenderIP").mProperties.selectedKey;
            vLanguage = this.getView().byId("idIPEmpLang").getValue();
            vPhoneNo = this.getView().byId("idIPEmpPNO").getValue();
            vLoginName = this.getView().byId("idIPEmpLogIn").getValue();
            vEmail = this.getView().byId("idIPEmpEmail").getValue();
            vCurrency = this.getView().byId("idIPEmpCurr").getValue();
            vSalary = this.getView().byId("idIPEmpSalAmt").getValue();
            vAccNo = this.getView().byId("idIPEmpAccNo").getValue();
            vBankID = this.getView().byId("idIPEmpBID").getValue();
            vBankName = this.getView().byId("idIPEmpBNM").getValue();
 
 
            var settings = {
                "url": "/odata/v4/catalog/createEmployee",
                "method": "POST",
                "headers": {
                    "Content-Type": "application/json"
                },
                "data": JSON.stringify({
                    "input": [{
                        "Currency_code": vCurrency,
                        "ID": vEmpID.toUpperCase(),
                        "accountNumber": vAccNo,
                        "bankId": vBankID,
                        "bankName": vBankName,
                        "email": vEmail,
                        "gender": vGender,
                        "language": vLanguage,
                        "loginName": vLoginName,
                        "nameFirst": vFirstName,
                        "nameInitials": vNameInitials,
                        "nameLast": vLastName,
                        "nameMiddle": vMiddleName,
                        "phoneNumber": vPhoneNo,
                        "salaryAmount": vSalary
                    }]
                })
            }
 
            $.ajax(settings).done(function (response) {
                if (response.value.error) {
                    if (response.value.error == 'ENTITY_ALREADY_EXISTS') {
                        MessageBox.error("Employee already exists"), {
                            onClose: function (oAction) {
                                this.getView().byId("idEmployeeTab").getBinding("items").refresh();
                            }
                        }
                    }
                } else {
                    MessageBox.information("Employee has been added...!"), {
                        onClose: function (oAction) {
                            this.getView().byId("idEmployeeTab").getBinding("items").refresh();
                        }
                    }
                }
            })
 
            this._closeDialog();
 
        },

        onPressEmployee: function(oEvent) {
            var vEmpID, vEmpDetails;
 
            vEmpID = oEvent.getSource().mProperties.text;
            vEmpDetails = oEvent.getSource().getBindingContext("mainModel").getObject();
 
            var oViewModel = this.getView().getModel("localEmpDetails");
            if(!oViewModel){
                oViewModel = new sap.ui.model.json.JSONModel();
                this.getView().setModel(oViewModel, "localEmpDetails")
            }
 
            oViewModel.setProperty("/localEmpID", vEmpDetails.ID);
            oViewModel.setProperty("/localFname", vEmpDetails.nameFirst);
            oViewModel.setProperty("/localLname", vEmpDetails.nameLast);
            oViewModel.setProperty("/localMname", vEmpDetails.nameMiddle);
            oViewModel.setProperty("/localNinitials", vEmpDetails.nameInitials);
            oViewModel.setProperty("/localGender", vEmpDetails.genderTxt);
            oViewModel.setProperty("/localLanguage", vEmpDetails.language);
            oViewModel.setProperty("/localLogin", vEmpDetails.loginName);
            oViewModel.setProperty("/localPhone", vEmpDetails.phoneNumber);
            oViewModel.setProperty("/localEmail", vEmpDetails.email);
            oViewModel.setProperty("/localCurrency", vEmpDetails.Currency);
            oViewModel.setProperty("/localSalary", vEmpDetails.salaryAmount);
            oViewModel.setProperty("/localAccount", vEmpDetails.accountNumber);
            oViewModel.setProperty("/localBankID", vEmpDetails.bandId);
            oViewModel.setProperty("/localBankName", vEmpDetails.bankName);
 
 
            if (!this.oEmpDialogDisplay) {
                this.oEmpDialogDisplay = this.loadFragment({
                    name: "employeeapp.fragments.DisplayEmployeeDialog"
                })
            };
            this.oEmpDialogDisplay.then(function (oDialog) {
                this.oDialog = oDialog;
                this.oDialog.open();
            }.bind(this));
        },

        
    });
});