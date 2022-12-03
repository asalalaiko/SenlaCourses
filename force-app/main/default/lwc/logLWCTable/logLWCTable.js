import { LightningElement, wire } from 'lwc';
import DATE_CREATED from '@salesforce/schema/LogLWC__c.CreatedDate';
import OBJECT_TYPE from '@salesforce/schema/LogLWC__c.ObjectType__c';
import ACTION_TYPE from '@salesforce/schema/LogLWC__c.ActionType__c';
import DESCRIPTION from '@salesforce/schema/LogLWC__c.Description__c';
import IS_SUCCESSFUL from '@salesforce/schema/LogLWC__c.IsSuccessful__c';
import ERROR_MESSAGE from '@salesforce/schema/LogLWC__c.ErrorMessage__c';
import logs from '@salesforce/apex/LogLWCController.getLogLWCs';

const fields = 'CreatedDate, ObjectType__c, ActionType__c, Description__c, IsSuccessful__c, ErrorMessage__c';

const COLUMNS = [
    { label: 'Created date', fieldName: DATE_CREATED.fieldApiName, type: 'date', sortable: true },
    { label: 'Type object', fieldName: OBJECT_TYPE.fieldApiName, type: 'text' },
    { label: 'Type action', fieldName: ACTION_TYPE.fieldApiName, type: 'text' },
    { label: 'Description', fieldName: DESCRIPTION.fieldApiName, type: 'text' },
    { label: 'Successful', fieldName: IS_SUCCESSFUL.fieldApiName, type: 'text' },
    { label: 'Error', fieldName: ERROR_MESSAGE.fieldApiName, type: 'text' },
    
];
export default class LogLWCTable extends LightningElement {

    columns = COLUMNS;
    defaultSortDirection = 'desc';
    sortDirection = 'desc';
    @wire(logs, { fields: fields})
    logs;
}