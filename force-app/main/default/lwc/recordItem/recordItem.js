import { LightningElement, api } from 'lwc';

export default class RecordItem extends LightningElement {
    @api objectName;
    @api recordId;
    @api fieldOne;
    @api fieldTwo;
    @api fieldThree;

}