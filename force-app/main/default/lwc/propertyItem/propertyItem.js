import { LightningElement, api } from 'lwc';

export default class PropertyItem extends LightningElement {
    @api propertyName;
    @api propertyPrice;
    @api propertyImage;
}