public with sharing class LogLWCController {

    @AuraEnabled(cacheable=false)
    public static LogLWC__c createLogLWC(String logObjectType, 
                                        String logActionType, 
                                        String logDescription, 
                                        Boolean LogIsSuccessful,
                                        String logErrorMessage) {
        LogLWCManager.LogLWCWrapper wrapper = new LogLWCManager.LogLWCWrapper();
        wrapper.objectType = logObjectType;
        wrapper.actionType = logActionType;
        wrapper.description = logDescription;
        wrapper.isSuccessful = LogIsSuccessful;
        wrapper.errorMessage = logErrorMessage;    

        LogLWC__c logLWC = LogLWCManager.createLogLWC(wrapper, true);
        return logLWC;
    }


    @AuraEnabled(cacheable=true)
    public static List<LogLWC__c> getLogLWCs(String fields) {
        return LogLWCManager.getLogLWCs(fields);
    }
}
