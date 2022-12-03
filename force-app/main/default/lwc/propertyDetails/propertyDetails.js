import { LightningElement, wire } from 'lwc';
import { getRecord, getFieldValue } from 'lightning/uiRecordApi';
import { subscribe, MessageContext } from 'lightning/messageService';
import PROPERTY_DETAILS_CHANNEL from '@salesforce/messageChannel/Property_Details__c';
import { PROPERTY_NAME,
    PROPERTY_IMAGE_URL,
    PROPERTY_SELLING_PRICE,
    PROPERTY_RENT_PRICE,
    PROPERTY_COUNTRY,
    PROPERTY_CITY,
    PROPERTY_ADDRESS } from 'c/utils';

const fields = [PROPERTY_NAME, PROPERTY_IMAGE_URL, PROPERTY_SELLING_PRICE, PROPERTY_RENT_PRICE,
                PROPERTY_COUNTRY, PROPERTY_CITY, PROPERTY_ADDRESS];

export default class PropertyDetails extends LightningElement {
    subscription = null;
    recordId;
    isLoading=false;
    error;

    @wire(getRecord, { recordId: '$recordId', fields })
    property;
    @wire(MessageContext)
    messageContext;

    get name() {
      
        return getFieldValue(this.property.data, PROPERTY_NAME);
      }
    
      get image() {
        return getFieldValue(this.property.data, PROPERTY_IMAGE_URL);
      }
    
      get sellingPrice() {
        return getFieldValue(this.property.data, PROPERTY_SELLING_PRICE);
      }

      get rentPrice() {
        return getFieldValue(this.property.data, PROPERTY_RENT_PRICE);
      }

      get country() {
        return getFieldValue(this.property.data, PROPERTY_COUNTRY);
      }

      get city() {
        return getFieldValue(this.property.data, PROPERTY_CITY);
      }

      get address() {
        this.isLoading=false;
        return getFieldValue(this.property.data, PROPERTY_ADDRESS);
      }

    subscribeToMessageChannel() {
      this.isLoading=true;
      try {
        this.subscription = subscribe(
            this.messageContext,
            PROPERTY_DETAILS_CHANNEL,
            (message) => this.handleMessage(message)
        );
      } catch (error){
        this.error = error;
      }
    }

    handleMessage(message) {
        this.recordId = message.propertyId;
    }

    connectedCallback() {
        this.subscribeToMessageChannel();
        console.log('---1>');
        console.log(this.error);
    
    }
      
    doError() {
      this.error = 'Whoops!';
 }

    handleError(error){
      this.error =  error;  
      console.log('--->');
      console.log(this.error);
    }
        
}