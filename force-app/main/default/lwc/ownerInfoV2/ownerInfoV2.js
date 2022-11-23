import { LightningElement, api, wire } from 'lwc';
import { getRecord, getFieldValue } from 'lightning/uiRecordApi';
import { NavigationMixin } from 'lightning/navigation';
import { PROPERTY_OWNER} from 'c/utils';

import PROPERTY_CONTACT from '@salesforce/schema/Property__c.Contact__c';

export default class OwnerInfoV2 extends NavigationMixin(LightningElement) {

    @api recordId;
    
    @wire(getRecord, { recordId: '$recordId', fields: [PROPERTY_OWNER] })
    property;
    

    get ownerId() {
        return getFieldValue(this.property.data, PROPERTY_OWNER);
    }
    

    navigateToRecordViewPage() {
        this[NavigationMixin.Navigate]({
            type: 'standard__recordPage',
            attributes: {
                recordId: this.ownerId,
                objectApiName: 'Contact', 
                actionName: 'view'
            }
        });
    }
}