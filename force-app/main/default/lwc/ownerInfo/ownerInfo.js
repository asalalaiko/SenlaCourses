import { LightningElement, api, wire } from 'lwc';
import { getRecord, getFieldValue } from 'lightning/uiRecordApi';
import { NavigationMixin } from 'lightning/navigation';

import OWNER from '@salesforce/schema/Contact.Id';
import OWNER_FIRST_NAME from '@salesforce/schema/Contact.FirstName';
import OWNER_LAST_NAME from '@salesforce/schema/Contact.LastName';
import OWNER_PHONE from '@salesforce/schema/Contact.Phone';
import OWNER_HOME_PHONE from '@salesforce/schema/Contact.HomePhone';
import OWNER_EMAIL from '@salesforce/schema/Contact.Email';
import OWNER_TOTAL_PROPERTY_PRICE from '@salesforce/schema/Contact.Total_Property_Price__c';

import PROPERTY_ID from '@salesforce/schema/Property__c.Id';
import PROPERTY_CONTACT from '@salesforce/schema/Property__c.Contact__c';

const owner_fields = [OWNER_FIRST_NAME, OWNER_LAST_NAME, OWNER_PHONE, OWNER_HOME_PHONE, OWNER_EMAIL, OWNER_TOTAL_PROPERTY_PRICE];

export default class OwnerInfo extends NavigationMixin(LightningElement) {

    @api recordId;
    
    @wire(getRecord, { recordId: '$recordId', fields: [PROPERTY_ID, PROPERTY_CONTACT] })
    property;
    @wire(getRecord, { recordId: '$ownerId', fields: owner_fields})
    owner;

    get ownerId() {
        return getFieldValue(this.property.data, PROPERTY_CONTACT);
    }


    get firstName(){
        return getFieldValue(this.owner.data, OWNER_FIRST_NAME);
    }

    get lastName(){
        return getFieldValue(this.owner.data, OWNER_LAST_NAME);
    }

    get phone(){
        return getFieldValue(this.owner.data, OWNER_PHONE);
    }

    get homePhone(){
        return getFieldValue(this.owner.data, OWNER_HOME_PHONE);
    }

    get email(){
        return getFieldValue(this.owner.data, OWNER_EMAIL);
    }

    get totalPrice(){
        return getFieldValue(this.owner.data, OWNER_TOTAL_PROPERTY_PRICE);
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