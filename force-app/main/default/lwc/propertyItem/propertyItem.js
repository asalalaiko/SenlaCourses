import { LightningElement, api, wire } from 'lwc';
import { publish, MessageContext } from 'lightning/messageService';
import PROPERTY_DETAILS_CHANNEL from '@salesforce/messageChannel/Property_Details__c';

export default class PropertyItem extends LightningElement {
    @api propertyId;
    @api propertyName;
    @api propertyPrice;
    @api propertyImage;

    @wire(MessageContext)
    
    messageContext;
    error = null;

    handleClick(event) {
        try {
            const payload = { 
                propertyId: this.propertyId,
            };
            publish(this.messageContext, PROPERTY_DETAILS_CHANNEL, payload);
        } catch(error) {
            this.error = error;
        }
    }

}