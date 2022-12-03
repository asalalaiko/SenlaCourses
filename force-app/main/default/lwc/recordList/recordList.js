import { LightningElement, api, wire } from 'lwc';
import { getObjectInfo } from 'lightning/uiObjectInfoApi';
import getData from '@salesforce/apex/UtilsController.getRecordsByFielsFromObject';

const pageSize = 8;

export default class RecordList extends LightningElement {
    @api objectApiName;
    @api firstField;
    @api secondField;
    @api thirdField;

    objectLabel;
    fields;
    quantityProperty;    
    quantityPages;
    numberPage=1;
    data=[];
    viewData=[];
    

    @wire(getObjectInfo, { objectApiName: "$objectApiName" })
    wiredRecordInfo({ error, data }) {
      if (data) {
        this.objectLabel = data.label;
      }
    }

    connectedCallback() {
        this.fields = this.firstField + ', '+ this.secondField + ', '+ this.thirdField;
    }

    
    @wire(getData, { objectName: "$objectApiName", fields: "Id"})
    dataList({ error, data }) {
      if(data){
         this.quantityProperty=data.length;
         this.quantityPages=Math.ceil(data.length/pageSize);
         this.data=data;
         this.viewData = this.paginate(this.data, pageSize, this.numberPage);
      }
      else if(error){
        console.log('error -->'+error);   
    }
  }

  changePage(event){
    this.numberPage = event.detail;
    this.viewData = this.paginate(this.data, pageSize, this.numberPage);
  }

 
   paginate(array, pageSize, pageNumber) {
    return array.slice((pageNumber - 1) * pageSize, pageNumber * pageSize);
  }
}