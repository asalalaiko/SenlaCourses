import { LightningElement, api } from 'lwc';


export default class PropertyCreation extends LightningElement {
    checkedRecordTypeIds=[];
    isChoseRecordType = false;
    objectName = 'Property__c';


    getRecordTypes(event){
        this.checkedRecordTypeIds = event.detail.checkedValue;
    }

    submitRecordType(event){
        if (this.checkedRecordTypeIds.length == 1) {
            //TODO /save record type ID
            this.isChoseRecordType = true;
        } else {
            alert('Choose one record type!!');
        }
    }




}