import { NavigationMixin } from 'lightning/navigation';

import PROPERTY_NAME from '@salesforce/schema/Property__c.Name';
import PROPERTY_SELLING_PRICE from '@salesforce/schema/Property__c.Selling_price__c';
import PROPERTY_RENT_PRICE from '@salesforce/schema/Property__c.Rent_price__c';
import PROPERTY_IMAGE_URL from '@salesforce/schema/Property__c.imageURL__c';
import PROPERTY_COUNTRY from '@salesforce/schema/Property__c.Country__c';
import PROPERTY_CITY from '@salesforce/schema/Property__c.City__c';
import PROPERTY_ADDRESS from '@salesforce/schema/Property__c.Address__c';
import PROPERTY_OWNER from '@salesforce/schema/Property__c.Contact__c';
import PROPERTY_OWNER_ID from '@salesforce/schema/Property__c.Contact__r.Id';
import PROPERTY_OWNER_FIRST_NAME from '@salesforce/schema/Property__c.Contact__r.FirstName';
import PROPERTY_OWNER_LAST_NAME from '@salesforce/schema/Property__c.Contact__r.LastName';
import PROPERTY_OWNER_PHONE from '@salesforce/schema/Property__c.Contact__r.Phone';
import PROPERTY_OWNER_HOME_PHONE from '@salesforce/schema/Property__c.Contact__r.HomePhone';
import PROPERTY_OWNER_EMAIL from '@salesforce/schema/Property__c.Contact__r.Email';
import PROPERTY_OWNER_TOTAL_PROPERTY_PRICE from '@salesforce/schema/Property__c.Contact__r.Total_Property_Price__c';

import CONTACT_OBJECT from '@salesforce/schema/Contact';
import PROPERTY_OBJECT from '@salesforce/schema/Property__c';

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
    PROPERTY_OBJECT,
    CONTACT_OBJECT,
    PROPERTY_NAME,
    PROPERTY_SELLING_PRICE,
    PROPERTY_RENT_PRICE,
    PROPERTY_IMAGE_URL,
    PROPERTY_COUNTRY,
    PROPERTY_CITY,
    PROPERTY_ADDRESS,
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