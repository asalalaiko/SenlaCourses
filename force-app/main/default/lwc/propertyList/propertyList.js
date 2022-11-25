import { LightningElement, wire } from 'lwc';
import { PROPERTY_OBJECT,
        PROPERTY_NAME,
        PROPERTY_SELLING_PRICE,
        PROPERTY_IMAGE_URL } from 'c/utils';
import propertyes from '@salesforce/apex/PropertyController.getPropertyes';

const fields = [PROPERTY_NAME.fieldApiName, PROPERTY_SELLING_PRICE.fieldApiName, PROPERTY_IMAGE_URL.fieldApiName];
const pageSize = 8;

export default class PropertyList extends LightningElement {
  quantityProperty;    
  quantityPages;
  numberPage=1;
  data=[];
  viewData=[];
  
  @wire(propertyes, { fields: fields.join(", ")})
    propertyList({ error, data }) {
      if(data){
        this.quantityProperty=data.length;
        this.quantityPages=Math.ceil(data.length/pageSize);
        this.data=data;
        this.viewData = this.paginate(this.data, pageSize, this.numberPage);
        console.log(data);   
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