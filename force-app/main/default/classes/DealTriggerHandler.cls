public class DealTriggerHandler extends TriggerHandler {
    public static final Id DEAL_TYPE_SALE = [SELECT Id FROM RecordType WHERE Name = 'Sale' LIMIT 1].Id;
    public static final String DEAL_STATUS_CLOSED_WON  = 'Closed Won';
    public static final String DEAL_STATUS_CLOSED_LOST  = 'Closed Lost';
    private List<Deal__c> deals = new List<Deal__c>();
    private List<Deal__c> dealsToUpdate = new List<Deal__c>();
    private Set<Id> propertyIds = new Set<Id>();

    public override void afterUpdate(){

        deals = [SELECT Id, Property__c 
                FROM Deal__c WHERE Id IN :Trigger.New AND RecordTypeId = :DEAL_TYPE_SALE AND Status__c = :DEAL_STATUS_CLOSED_WON];
        
        for(Deal__c deal : deals){
            propertyIds.add(deal.Property__c);            
        } 

        for(Id pId : propertyIds){
            dealsToUpdate.add(Database.query('SELECT Id FROM Deal__c WHERE Status__c = :DEAL_STATUS_CLOSED_WON AND Property__c = :pId'));
        }

        for(Deal__c deal : dealsToUpdate){
            deal.Status__c = DEAL_STATUS_CLOSED_LOST;
        } 

        if (dealsToUpdate.size() > 0){
            update dealsToUpdate;
        }
    }



}
