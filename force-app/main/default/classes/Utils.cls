public  class Utils {
    

    public static void checkDatabaseSaveResults(Database.SaveResult[] saveResults, List<SObject> records, String errorSource) {
    
        String logMsg = '';
    
        for (Integer i = 0; i < saveResults.size(); i++) {
            if (saveResults[i].isSuccess()) continue;

            logMsg += 'DML operation failed for record: ' + records[i].Id + '\ncause:\n';
    
            for (Database.Error err: saveResults[i].getErrors()) {
                logMsg += err.getMessage() + '\n';
                }
        }

            if (String.isBlank(logMsg)) LogManager.log(errorSource, logMsg, true);
    }

    public static Id findRecordTypeByName(String name){
        return Database.query('SELECT Id FROM RecordType WHERE Name = :name Limit 1').Id;
    } 

    public static RecordType findRecordTypeById(Id id){
        return Database.query('SELECT Id, Name FROM RecordType WHERE Id = :id Limit 1');
    }

    public static String getRecordTypeNameById(String objectName, Id strRecordTypeId)
    {
        return Schema.getGlobalDescribe().get(objectName).getDescribe().getRecordTypeInfosById().get(strRecordTypeId).getName();
    }

    public static List<SObject> getRecordsByFielsFromObject(String objectName, String fields)
    {
        return Database.query('SELECT ' + fields + ' FROM ' +objectName);
    }

    
}