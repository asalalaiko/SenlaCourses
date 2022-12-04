import { LightningElement, api } from 'lwc';
import { PROPERTY_OBJECT} from 'c/utils';

export default class PropertyCreationV2 extends LightningElement {
    @api recordId;
    objectName = PROPERTY_OBJECT;

}