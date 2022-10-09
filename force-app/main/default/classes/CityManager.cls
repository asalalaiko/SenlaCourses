public class CityManager {

    public static City__c getCityById(Id id, String fields) {
        return Database.query('SELECT ' + fields + ' FROM City__c WHERE Id = :id LIMIT 1');
    } 

    public static Country__c getCountryByCityId(Id id) {
        Id countryId = [SELECT Id, Country__c FROM City__c  WHERE Id = :id LIMIT 1].Country__c;
        return Database.query('SELECT Id, Name FROM Country__c WHERE Id = :countryId LIMIT 1');
    } 
}
