public class BatchEndedLeaseDeals implements Database.Batchable<sObject> {

private static final Id DEAL_TYPE_LEASE = [SELECT Id FROM RecordType WHERE Name = 'Lease' LIMIT 1].Id;


public Database.QueryLocator start(Database.BatchableContext bc) {

    return Database.getQueryLocator(
        'SELECT ID ' +
        'FROM Deal__c ' +
        'Where RecordTypeId = ' + DEAL_TYPE_LEASE + 
        'AND Finish_lease__c = TOMORROW'
    );
}
public void execute(Database.BatchableContext bc, List<Deal__c> deals){
    List <NotifyClientRentEnding__e> eventList = new  List <NotifyClientRentEnding__e>();
    List <Id> idsContact = new List<Id>();

    for (Deal__c deal : deals) {
        NotifyClientRentEnding__e event = new NotifyClientRentEnding__e(DeaI__c = deal.Id, Info__c = JSON.serialize(new InfoByBatchEndLease.Info(deal), true)); 
        eventList.add(event);
        idsContact.add(deal.Contact__c);
    }

    Database.SaveResult[] sr = EventBus.publish(eventList);
    Utils.checkDatabaseSaveResults(sr,eventList,'GetEndedLeaseDealsToPlatformEvents');

    SendEmailEndedLease.sendEmails(idsContact);

}
public void finish(Database.BatchableContext bc){
      
    
}
}