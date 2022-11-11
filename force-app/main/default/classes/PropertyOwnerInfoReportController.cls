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

    public String propertyOwnerName{get;set;}
    public Decimal totalPrice{get;set;}

    public PropertyOwnerInfoReportController(){
        propertyOwnerName = ContactManager.getContactById(ApexPages.currentPage().getParameters().get('id'),'Name').Name;
        totalPrice = 0.0;
    }

    public List<PropertyInfo> getPropertyInfo() {
        Id idOwner = ApexPages.currentPage().getParameters().get('id');
        List<Deal__c> deals = DealManager.getClosedWonDealsByOwner(idOwner);
        List<PropertyInfo> listPropertyInfo = new List<PropertyInfo>();
        Boolean isFind;
        String typeProperty;

        for (Deal__c deal : deals) {
            isFind = false;
            typeProperty = Utils.getRecordTypeNameById('Property__c', deal.Property__r.RecordTypeId);
            for (PropertyInfo propertyInfo : listPropertyInfo) {
                if (typeProperty == propertyInfo.type) {
                    propertyInfo = addDealToPropertyInfo(deal, propertyInfo);
                    totalPrice += deal.Total_Cost__c;
                    isFind = true;
                }
            }
            if (!isFind) {
                totalPrice += deal.Total_Cost__c;
                listPropertyInfo.add(new PropertyInfo(typeProperty, 1, deal.Transaction_amount__c, deal.Total_Cost__c));
            }
        }
        return listPropertyInfo;
    }

    PropertyInfo addDealToPropertyInfo(Deal__c deal, PropertyInfo propertyInfo){
        propertyInfo.amount ++;
        propertyInfo.sumTransaction += deal.Transaction_amount__c;
        propertyInfo.sumTotal += deal.Total_Cost__c;
        return propertyInfo;
    }
}