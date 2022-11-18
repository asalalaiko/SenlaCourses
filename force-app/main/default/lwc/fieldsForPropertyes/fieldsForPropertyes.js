import { LightningElement, api, track } from 'lwc';
import PROPERTY_OBJECT from '@salesforce/schema/Property__c';
import FIELD_ADDRESS from '@salesforce/schema/Property__c.Address__c';
import FIELD_SELLING_PRICE from '@salesforce/schema/Property__c.Selling_price__c';
import FIELD_RENT_PRICE from '@salesforce/schema/Property__c.Rent_price__c'


export default class FieldsFromPropertyes extends LightningElement {
    @api recordId;
    @track elements = [{ id: 0 }];

    keyIndex = 0;
    
}