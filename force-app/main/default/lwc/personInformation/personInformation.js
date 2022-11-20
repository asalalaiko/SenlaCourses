import { LightningElement, track } from 'lwc';
import labelName from '@salesforce/label/c.PersonsInformation';
import generateData from './generateData';

const columns = [
    { label: 'First Name', fieldName: 'firstName' },
    { label: 'Last Name', fieldName: 'lastName' },
    { label: 'Gender', fieldName: 'gender' },
    { label: 'Birthday', fieldName: 'birthday', type: 'date'},
    { label: 'Email', fieldName: 'email', type: 'email' },
];

export default class PersonInformation extends LightningElement {
    @track data =[];
    searchKeyEmail;
    dateFrom;
    dateTo;
    gender;
    label = {labelName};
    columns = columns;
    defaultSortDirection = 'asc';
    sortDirection = 'asc';
    isDisabledCheckboxFemale = false;
    isDisabledCheckboxMale = false;
   
    connectedCallback(){
          this.toFilter();
    }

    get options() {
        return [
            { label: 'First Name', value: 'firstName' },
            { label: 'Last Name', value: 'lastName' },
            { label: 'Email', value: 'email'},
        ];
    }

    changeForSort(event) {
        const { value: sortedBy, sortDirection} = event.detail;
        const cloneData = [...this.data];

        cloneData.sort(this.sortBy(sortedBy, sortDirection === 'asc' ? -1 : 1));
        this.data = cloneData;
        this.sortDirection = sortDirection;
        this.sortedBy = sortedBy;
    }

    sortBy(field, reverse, primer) {
        const key = primer
            ? function (x) {
                  return primer(x[field]);
              }
            : function (x) {
                  return x[field];
              };

        return function (a, b) {
            a = key(a);
            b = key(b);
            return reverse * ((a > b) - (b > a));
        };
    }

    toFilter(){
        let data = generateData();

        if (this.searchKeyEmail) {
            let filterData = [];
            for (let record of data){
                let strValue = String(record.email).toLowerCase();
                if(strValue.includes(this.searchKeyEmail)){
                    filterData.push(record)
                }
            }
            data = filterData;            
        }
        if (this.dateFrom) {
            let filterData = [];
            for (let record of data) {
                if(new Date(this.dateFrom)<new Date(record.birthday)){
                    filterData.push(record);
                }
            }
            data = filterData;
        }
        if (this.dateTo) {
            let filterData = [];
            for (let record of data) {
                if(new Date(this.dateTo)>new Date(record.birthday)){
                    filterData.push(record);
                }
            }
            data = filterData;
        }
        if (this.gender) {
            let filterData = [];
            for (let record of data) {
                if(record.gender == this.gender){
                    filterData.push(record);
                }
            }
            data = filterData;
        }

        this.data = data;
    }

    handleSearchEmail(event){
        this.searchKeyEmail = event.target.value.toLowerCase();
        this.toFilter();
    }

    changeDateFrom(event){
        this.dateFrom = event.target.value;
        if (this.isCheckPeriod(this.dateFrom, this.dateTo)) {
            this.toFilter();
        }
    }

    changeDateTo(event){
        this.dateTo = event.target.value;
        if (this.isCheckPeriod(this.dateFrom, this.dateTo)) {
            this.toFilter();
        }
    }

    changeMale(event){
        this.isDisabledCheckboxFemale = !this.isDisabledCheckboxFemale;

        if(event.target.checked) {
            this.gender = 'Male';
            this.toFilter();
        } else {
           this.gender = ''; 
           this.toFilter();
        }
    }

    changeFemale(event){
        this.isDisabledCheckboxMale = !this.isDisabledCheckboxMale;
        
        if(event.target.checked) {
            this.gender = 'Female';
            this.toFilter();
        } else {
           this.gender = ''; 
           this.toFilter();
        }
    }

    isCheckPeriod(from, to){
        if(to<from && to!=''){
            alert('Error to date');
            return false;
        } else {
            return true;
        }
    }

    resetAll(){
        this.searchKeyEmail='';
        this.dateFrom='';
        this.dateTo='';
        this.gender='';
        this.isDisabledCheckboxFemale = false;
        this.isDisabledCheckboxMale = false;
        this.template.querySelector('form').reset();
        
        this.toFilter();
    }
}