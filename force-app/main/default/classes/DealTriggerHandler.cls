public class DealTriggerHandler extends TriggerHandler {
    public static final Id DEAL_TYPE_SALE_ID = [SELECT Id FROM RecordType WHERE Name = 'Sale' LIMIT 1].Id;
    public static final String DEAL_STATUS_CLOSED_WON  = 'Closed Won';
    public static final String DEAL_STATUS_CLOSED_LOST  = 'Closed Lost';
    
    

    public override void afterUpdate(){
        List <Id> propertyIds = new List<Id>();

        for(Id dealId : Trigger.newMap.keySet()) {
            Deal__c newDeal = (Deal__c)Trigger.newMap.get(dealId);
            if (newDeal.RecordTypeId != DealManager.DEAL_TYPE_SALE_ID || newDeal.Status__c != DEAL_STATUS_CLOSED_WON) continue;
            
            if (newDeal.Status__c != Trigger.oldMap.get(dealId).get(Deal__c.Status__c)) propertyIds.add(newDeal.Property__c);
            }
        
        if (!propertyIds.isEmpty()) {
            List<Deal__c> dealToChange = DealManager.getNotClosedSaleDealsByProperties(propertyIds);
            for (Deal__c dl : dealToChange) {
                dl.Status__c = 'Closed Lost';
        }

            Database.SaveResult[] results = Database.update(dealToChange, false);
            Utils.checkDatabaseSaveResults(results, dealToChange, 'DealTriggerHandler');
            
        }
    }

}