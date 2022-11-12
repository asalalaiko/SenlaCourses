function person(firstName, lastName, gender, birthday, email){
    this.firstName = firstName;
    this.lastName = lastName;
    this.gender = gender;
    this.birthday = birthday;
    this.email = email;
}


export default function generateData() {
    return[
        new person('Ivan', 'Ivanov', 'Male', '1994-10-1', 'iv@djhwvd.ru'),
        new person('Petr', 'Ivanov', 'Male', '1985-2-10', 'pe@djhwvd.ru'),
        new person('Jennifer', 'J. Martin', 'Female', '1994-9-1', 'beau_dubuqu1@yahoo.com'),
        new person('Stanley', 'Jin', 'Male', '1958-11-21', 'don_ward2016@hotmail.com'),
        new person('Vera', 'Maria', 'Female', '1934-1-21', 'gillian_colli@gmail.com'),
        new person('Janet', 'Ankney', 'Female', '1975-4-11', 'major_erdma6@gmail.com'),
        new person('Raquel', 'Morris', 'Female', '1988-2-14', 'eliseo.conn@gmail.com'),
        new person('Eric', 'Whalen', 'Male', '1988-8-10', 'wyatt19911985@hotmail.com'),
        new person('Clarence', 'Duffy', 'Male', '2002-10-31', 'gracie1980@gmail.com'),
        new person('Barbara', 'Jackson', 'Female', '1983-4-19', 'corine1983@gmail.com'),
        new person('Patricia', 'Dean', 'Female', '1986-3-21', 'theresia1979@yahoo.com'),
        new person('John', 'Williams', 'Male', '1973-12-10', 'elyse2007@hotmail.com'),
        new person('Bobby', 'Bolduc', 'Male', '2004-10-17', 'vladimir2017@hotmail.com'),
        new person('Corrine', 'Larsen', 'Female', '1990-6-12', 'desiree1985@gmail.com'),
    ]
}