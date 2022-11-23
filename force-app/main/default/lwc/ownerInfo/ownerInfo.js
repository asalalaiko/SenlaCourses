import { LightningElement, api, wire } from 'lwc';
import { getRecord, getFieldValue } from 'lightning/uiRecordApi';
import { NavigationMixin } from 'lightning/navigation';
import { STANDART_RECORD_PAGE_TYPE,
        PAGE_ACTION_NAME_VIEW,
        CONTACT_OBJECT,
        PROPERTY_OWNER_ID,
        PROPERTY_OWNER_FIRST_NAME,
        PROPERTY_OWNER_LAST_NAME,
        PROPERTY_OWNER_PHONE,
        PROPERTY_OWNER_HOME_PHONE,
        PROPERTY_OWNER_EMAIL,
        PROPERTY_OWNER_TOTAL_PROPERTY_PRICE,
        PROPERTY_OWNER_FIELDS,
        navigateTo} from 'c/utils';


export default class OwnerInfo extends NavigationMixin(LightningElement) {

    @api recordId;
    
    @wire(getRecord, { recordId: '$recordId', fields: PROPERTY_OWNER_FIELDS})
    owner;

    get firstName(){
        return getFieldValue(this.owner.data, PROPERTY_OWNER_FIRST_NAME);
    }

    get lastName(){
        return getFieldValue(this.owner.data, PROPERTY_OWNER_LAST_NAME);
    }

    get phone(){
        return getFieldValue(this.owner.data, PROPERTY_OWNER_PHONE);
    }

    get homePhone(){
        return getFieldValue(this.owner.data, PROPERTY_OWNER_HOME_PHONE);
    }

    get email(){
        return getFieldValue(this.owner.data, PROPERTY_OWNER_EMAIL);
    }

    get totalPrice(){
        return getFieldValue(this.owner.data, PROPERTY_OWNER_TOTAL_PROPERTY_PRICE);
    }

    navigateToRecordViewPage() {
        navigateTo(
            this,
            STANDART_RECORD_PAGE_TYPE, 
            getFieldValue(this.owner.data, PROPERTY_OWNER_ID),
            CONTACT_OBJECT,
            PAGE_ACTION_NAME_VIEW
        );
    }
}