import { LightningElement, track } from 'lwc';
import labelName from '@salesforce/label/c.PersonsInformation';

function person(firstName, lastName, gender, birthday, email){
    this.firstName = firstName;
    this.lastName = lastName;
    this.gender = gender;
    this.birthday = birthday;
    this.email = email;
}

const columns = [
    { label: 'First Name', fieldName: 'firstName' },
    { label: 'Last Name', fieldName: 'lastName' },
    { label: 'Gender', fieldName: 'gender' },
    { label: 'Birthday', fieldName: 'birthday', type: 'date'},
    { label: 'Email', fieldName: 'email', type: 'email' },
];

export default class PersonInformation extends LightningElement {
    label = {labelName};
    columns = columns;
    defaultSortDirection = 'asc';
    sortDirection = 'asc';

    
    @track data =[
        new person('Ivan', 'Ivanov', 'Male', '1994-10-1', 'iv@djhwvd.ru'),
        new person('Petr', 'Ivanov', 'Male', '1985-2-10', 'pe@djhwvd.ru'),
        new person('Jennifer', 'J. Martin', 'Female', '1994-9-1', 'beau_dubuqu1@yahoo.com'),
        // new person('Stanley', 'Jin', 'Male', '1958-11-21', 'don_ward2016@hotmail.com'),
        // new person('Vera', 'Maria', 'Female', '1934-1-21', 'gillian_colli@gmail.com'),
        // new person('Janet', 'Ankney', 'Female', '1975-4-11', 'major_erdma6@gmail.com'),
        // new person('Raquel', 'Morris', 'Female', '1988-2-14', 'eliseo.conn@gmail.com'),
        // new person('Eric', 'Whalen', 'Male', '1988-8-10', 'wyatt19911985@hotmail.com'),
        // new person('Clarence', 'Duffy', 'Male', '2002-10-31', 'gracie1980@gmail.com'),
        // new person('Barbara', 'Jackson', 'Female', '1983-4-19', 'corine1983@gmail.com'),
        // new person('Patricia', 'Dean', 'Female', '1986-3-21', 'theresia1979@yahoo.com'),
        // new person('John', 'Williams', 'Male', '1973-12-10', 'elyse2007@hotmail.com'),
        // new person('Bobby', 'Bolduc', 'Male', '2004-10-17', 'vladimir2017@hotmail.com'),
        // new person('Corrine', 'Larsen', 'Female', '1990-6-12', 'desiree1985@gmail.com'),
    ];
    initialData;

    connectedCallback(){
        this.initialData = this.data;
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

    handleSearchEmail(event) {
        const searchKey = event.target.value.toLowerCase();

        if (searchKey) {
            this.data = this.initialData;
 
            if (this.data) {
                let searchData = [];
 
                for (let record of this.data) {
                    let valuesArray = Object.values(record.email);
 
                    for (let val of valuesArray) {

                        let strVal = String(val);
 
                        if (strVal) {
 
                            if (strVal.toLowerCase().includes(searchKey)) {
                                searchData.push(record);
                                break;
                            }
                        }
                    }
                }
                this.data = searchData;
            }
        } else {
            this.data = this.initialData;
        }
    }

    changeDateFrom(event){
        const dateFrom = event.target.value;
        let searchData = [];

        for (let record of this.data) {
            if(new Date(dateFrom)<new Date(record.birthday)){
                searchData.push(record);

            }
        }
        this.data = searchData;
    }

}