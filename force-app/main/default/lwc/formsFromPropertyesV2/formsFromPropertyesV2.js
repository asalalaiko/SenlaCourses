import { LightningElement, api, wire, track} from 'lwc';
import { getObjectInfo } from 'lightning/uiObjectInfoApi';
import createLogLWC from '@salesforce/apex/LogLWCController.createLogLWC';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class FormsFromPropertyesV2 extends LightningElement {
    @api recordId;
    @api objectNameToGetRecordTypes;
    @track value=[];
    @track recordTypes =[];
    @track elements = [{ id: 0 }];
    isDeleteButtonDisabled = true;
    isAddButtonDisabled = false;
    isChoseRecordType = false;
    recordTypeId;

    @wire(getObjectInfo, { objectApiName: '$objectNameToGetRecordTypes' })


    getObjectInfo({ error, data }) {
        if (data) {
            this.recordTypes = [];
            for (let key in data.recordTypeInfos) {
                if(data.recordTypeInfos[key].defaultRecordTypeMapping) {
                    this.value.push(key);
                }
                if(!data.recordTypeInfos[key].master) this.recordTypes.push({ value: key, label:data.recordTypeInfos[key].name});
            }
        }
        else if (error) {
            console.log('Error while get record types');
            this.recordTypes = [];
        }
    }

    handleChangeRecordType(event){
        this.value = event.detail.value;
    }

    submitRecordType(event){
        if (this.value.length == 1) {
            this.recordTypeId = this.value.checkedValue
            this.isChoseRecordType = true;
        } else {
            alert('Choose one record type!!');
        }
    }

    addRow() {
        if(this.elements.length < 3){
            let newElement = {id: this.elements.length};
            this.elements.push(newElement);
        }
        if (this.elements.length == 2) {
            this.isDeleteButtonDisabled = false;
        }
        if (this.elements.length == 3) {
            this.isAddButtonDisabled = true;
        }
    }

    deleteRow(){
        if (this.elements.length > 1){
            this.elements.pop();
        }
        if (this.elements.length == 1) {
            this.isDeleteButtonDisabled = true;
        }
        if (this.elements.length == 2) {
            this.isAddButtonDisabled = false;
        }
    }

    handleCancel() {
        this.elements = [{ id: 0 }];
        this.isChoseRecordType = false;
    }

    handleSubmit() {
        let isValidity = true;
        let descriptionLogLWC = 'Add' + this.elements.length + ' records';
        this.template.querySelectorAll('lightning-input-field').forEach(element => {
            isValidity = isValidity && element.reportValidity();
        });
        
        if (isValidity) {
            try {
                this.template.querySelectorAll('lightning-record-edit-form').forEach(element => {
                    element.submit();
                });
                this.addLogLWC('Insert', descriptionLogLWC, true, '');
                this.displaySuccess();
                this.handleCancel();
            } catch(error) {
                this.addLogLWC('Insert', descriptionLogLWC, false, error.message);
                this.displayError(error);
            }
        } 
    }

    displaySuccess() {
        const toastEvent = new ShowToastEvent({
            title: "Property creation",
            message: "Property is successfully created",
            variant: "success"
        });
        this.dispatchEvent(toastEvent);
    }

    displayError(error) {
        const toastEvent = new ShowToastEvent({
            title: "Property is not created",
            message: error.getMessage(),
            variant: "destructive"
        });
        this.dispatchEvent(toastEvent);
    }

    addLogLWC(actionType, logDescription, isSuccessful, errorMessage) {
        createLogLWC({
            logObjectType: this.objectNameToGetRecordTypes, 
            logActionType: actionType,
            logDescription: logDescription,
            LogIsSuccessful: isSuccessful,
            logErrorMessage: errorMessage
        });
    }
}