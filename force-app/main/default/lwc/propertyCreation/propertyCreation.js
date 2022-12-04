import { LightningElement, api } from 'lwc';
import { PROPERTY_OBJECT} from 'c/utils';

export default class PropertyCreation extends LightningElement {
    @api recordId;
    checkedRecordTypeIds=[];
    isChoseRecordType = false;
    objectName = PROPERTY_OBJECT;
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