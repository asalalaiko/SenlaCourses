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
  isLoading = true;
  error = null;
  
  @wire(propertyes, { fields: fields.join(", ")})
    propertyList({ error, data }) {
      if(data){
        this.quantityProperty=data.length;
        this.quantityPages=Math.ceil(data.length/pageSize);
        this.data=data;
        this.viewData = this.paginate(this.data, pageSize, this.numberPage);
      }
      else if(error){
        this.error = error;   
    }
    this.isLoading = false;
  }

  changePage(event){
    this.isLoading = true;
    this.numberPage = event.detail;
    this.viewData = this.paginate(this.data, pageSize, this.numberPage);
    this.isLoading = false;
  }

 
   paginate(array, pageSize, pageNumber) {
    return array.slice((pageNumber - 1) * pageSize, pageNumber * pageSize);
  }
}