public with sharing class UtilsController {
    @AuraEnabled(cacheable=true)
    public static List<SObject> getRecordsByFielsFromObject(String objectName, String fields) {
        return Utils.getRecordsByFielsFromObject(objectName, fields);
    }
}
