import { NavigationMixin } from 'lightning/navigation';

import PROPERTY_OWNER from '@salesforce/schema/Property__c.Contact__c';
import PROPERTY_OWNER_ID from '@salesforce/schema/Property__c.Contact__r.Id';
import PROPERTY_OWNER_FIRST_NAME from '@salesforce/schema/Property__c.Contact__r.FirstName';
import PROPERTY_OWNER_LAST_NAME from '@salesforce/schema/Property__c.Contact__r.LastName';
import PROPERTY_OWNER_PHONE from '@salesforce/schema/Property__c.Contact__r.Phone';
import PROPERTY_OWNER_HOME_PHONE from '@salesforce/schema/Property__c.Contact__r.HomePhone';
import PROPERTY_OWNER_EMAIL from '@salesforce/schema/Property__c.Contact__r.Email';
import PROPERTY_OWNER_TOTAL_PROPERTY_PRICE from '@salesforce/schema/Property__c.Contact__r.Total_Property_Price__c';

import CONTACT_OBJECT from '@salesforce/schema/Contact';

const STANDART_RECORD_PAGE_TYPE = 'standard__recordPage';

const PAGE_ACTION_NAME_VIEW = 'view';

const PROPERTY_OWNER_FIELDS = [
    PROPERTY_OWNER_ID,
    PROPERTY_OWNER_FIRST_NAME,
    PROPERTY_OWNER_LAST_NAME,
    PROPERTY_OWNER_PHONE,
    PROPERTY_OWNER_HOME_PHONE,
    PROPERTY_OWNER_EMAIL,
    PROPERTY_OWNER_TOTAL_PROPERTY_PRICE,
];

const navigateTo = (page, type, recordId, objectApiName, actionName) => {
    page[NavigationMixin.Navigate] ({
        type: type,
        attributes: {
            recordId: recordId,
            objectApiName: objectApiName,
            actionName: actionName,
        },
    });
}


export{
    PROPERTY_OWNER,
    PROPERTY_OWNER_ID,
    PROPERTY_OWNER_FIRST_NAME,
    PROPERTY_OWNER_LAST_NAME,
    PROPERTY_OWNER_PHONE,
    PROPERTY_OWNER_HOME_PHONE,
    PROPERTY_OWNER_EMAIL,
    PROPERTY_OWNER_TOTAL_PROPERTY_PRICE,
    PROPERTY_OWNER_FIELDS,
    STANDART_RECORD_PAGE_TYPE,
    PAGE_ACTION_NAME_VIEW,
    navigateTo,

}