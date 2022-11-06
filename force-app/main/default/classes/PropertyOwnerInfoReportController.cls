public class PropertyOwnerInfoReportController {

    public class PropertyInfo {
        public String type {get; set;}
        public Integer amount {get; set;}   
        public Decimal sumTransaction {get; set;}   
        public Decimal sumTotal {get; set;} 
        
        public PropertyInfo(String type, Integer amount, Decimal sumTransaction, Decimal sumTotal){
            this.type = type;
            this.amount = amount;
            this.sumTransaction = sumTransaction;
            this.sumTotal = sumTotal;

        }
    }

    public List<Deal__c> deals; 
    public List<PropertyInfo> prInfo; 
    public String propertyOwnerName{get;set;}
    public Decimal totalPrice{get;set;}

    public PropertyOwnerInfoReportController(){
        propertyOwnerName = ContactManager.getContactById(ApexPages.currentPage().getParameters().get('id'),'Name').Name;
        totalPrice = 0.0;
    }

    public List<PropertyInfo> getPropertyInfo() {
        Id idOwner = ApexPages.currentPage().getParameters().get('id');
        deals = DealManager.getClosedWonDealsByOwner(idOwner);
        prInfo = new List<PropertyInfo>();
        Boolean find;
        String typeProperty;

        for (Deal__c deal : deals) {
            find = false;
            typeProperty = Utils.findRecordTypeById(deal.Property__r.RecordTypeId).Name;

            for (PropertyInfo pr : prInfo) {
                if (typeProperty == pr.type) {
                    pr.amount += 1;
                    pr.sumTransaction += deal.Transaction_amount__c;
                    pr.sumTotal += deal.Total_Cost__c;
                    totalPrice += deal.Total_Cost__c;
                    find = true;
                }
            }
            if (!find) {
                totalPrice += deal.Total_Cost__c;
                prInfo.add(new PropertyInfo(typeProperty, 1, deal.Transaction_amount__c, deal.Total_Cost__c));
            }
        }
        return prInfo;
    }
}