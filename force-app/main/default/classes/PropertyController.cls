public with sharing class PropertyController {

    @AuraEnabled(cacheable=true)
    public static List<Property__c> getPropertyes(String fields) {
        return PropertyManager.getPropertyes(fields);
    }
}
