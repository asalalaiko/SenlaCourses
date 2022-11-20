import { LightningElement, api, track } from 'lwc';


export default class FieldsFromPropertyes extends LightningElement {
    @api recordId;
    @api recordTypeId;
    @track elements = [{ id: 0 }];
    isDeleteButtonDisabled = true;
    isAddButtonDisabled = false;

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
        this.dispatchEvent(new CustomEvent("recordcreation"));
    }

    handleSubmit() {
        let isValidity = true;
        this.template.querySelectorAll('lightning-input-field').forEach(element => {
            isValidity = isValidity && element.reportValidity();
        });
        
        if (isValidity) {
            try {
                this.template.querySelectorAll('lightning-record-edit-form-create').forEach(element => {
                    element.submit();
                });
                console.log('---------->'+ element);
                this.displaySuccess();
                this.handleCancel();
            } catch(error) {
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
    
}