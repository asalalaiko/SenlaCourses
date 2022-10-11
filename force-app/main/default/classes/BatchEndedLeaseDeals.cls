public class BatchEndedLeaseDeals implements Database.Batchable<sObject> {

    public static final String FIELDS = 'Id, CreatedDate'
                                        + ', Contact__r.Id'
                                        + ', Contact__r.FirstName'
                                        + ', Contact__r.LastName'
                                        + ', Contact__r.Email'
                                        + ', Property__r.Id'
                                        + ', Property__r.Contact__r.Id'
                                        + ', Property__r.Contact__r.FirstName'
                                        + ', Property__r.Contact__r.LastName'
                                        + ', Property__r.Contact__r.Email' 
                                        + ', Property__r.Country__c'
                                        + ', Property__r.City__c'
                                        + ', Property__r.Address__c'
                                        + ', Property__r.Latitude__c' 
                                        + ', Property__r.Longitude__c' 
                                        + ', Start_lease__c'
                                        + ', Finish_lease__c';

public Database.QueryLocator start(Database.BatchableContext bc) {

    return Database.getQueryLocator(
        'SELECT ' + FIELDS + 
        ' FROM Deal__c ' +
        'WHERE Finish_lease__c = TOMORROW'
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
    Utils.checkDatabaseSaveResults(sr,eventList,'BatchEndedLeaseDeals');
    SendEmailEndedLease.sendEmails(idsContact);

}
public void finish(Database.BatchableContext bc){
      
    
}
}