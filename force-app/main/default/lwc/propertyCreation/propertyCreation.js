import { LightningElement, api } from 'lwc';


export default class PropertyCreation extends LightningElement {
    checkedRecordTypeIds=[];
    isChoseRecordType = false;
    objectName = 'Property__c';
    recordTypeId;


    getRecordTypes(event){
        this.checkedRecordTypeIds = event.detail.checkedValue;
    }

    submitRecordType(event){
        if (this.checkedRecordTypeIds.length == 1) {
            this.recordTypeId = this.checkedRecordTypeIds.checkedValue
            this.isChoseRecordType = true;
        } else {
            alert('Choose one record type!!');
        }
    }

    handleRecordCreation(event) {
        this.isChoseRecordType = false;
    }


}