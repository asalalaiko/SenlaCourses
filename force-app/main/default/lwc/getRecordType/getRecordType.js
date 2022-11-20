import { LightningElement, api, wire, track } from 'lwc';
import { getObjectInfo } from 'lightning/uiObjectInfoApi';

export default class GetRecordType extends LightningElement {
    @api objectNameToGetRecordTypes;
    @track value=[];
    @track recordTypes =[];
    @wire(getObjectInfo, { objectApiName: '$objectNameToGetRecordTypes' })
    
    getObjectInfo({ error, data }) {
        if (data) {
            this.recordTypes = [];
            for (let key in data.recordTypeInfos) {
                if(data.recordTypeInfos[key].defaultRecordTypeMapping) {
                    this.value.push(key);
                    this.createEvent();
                }
                if(!data.recordTypeInfos[key].master) this.recordTypes.push({ value: key, label:data.recordTypeInfos[key].name});
            }
        }
        else if (error) {
            console.log('Error while get record types');
            this.recordTypes = [];
        }
    }

    handleChange(event){
        this.value = event.detail.value;
        this.createEvent();
    }

    createEvent(){
        this.dispatchEvent(new CustomEvent("recordtypes", {
            detail: {
                checkedValue: this.value,
            }
        }));
    }
    
}