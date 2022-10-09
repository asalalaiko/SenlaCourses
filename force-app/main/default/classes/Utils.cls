public class Utils {
    

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


    
    public static String getJSONInfoLeaseDealByDealId(Id id) {
            
            Deal__c deal = DealManager.getDealById(id, 'id, Contact__c, Contact_buyer__c, Start_lease__c, Finish_lease__c');
            Id pId = DealManager.getDealById(id, 'Property__c').Property__c;
            
            Contact clientDeal = ContactManager.getContactById(deal.Contact_buyer__c, 'id, FirstName, LastName, Email');
            Contact ownerDeal = ContactManager.getContactById(deal.Contact__c, 'id, FirstName, LastName, Email');

            String pCountry = PropertyManager.getCountryPropetyById(pId).Name;
            String pCity = PropertyManager.getCityPropetyById(pId).Name;
            String pAddress = PropertyManager.getAddressPropetyById(pId);
            String pLatitude = PropertyManager.getLatitudePropetyById(pId);
            String pLongitude = PropertyManager.getLongitudePropetyById(pId);

            Datetime dt = Datetime.now();
            Date sd = deal.Start_lease__c;
            Date ed = deal.Finish_lease__c;

            Client client = new Client (clientDeal.Id, clientDeal.FirstName, clientDeal.LastName, clientDeal.Email);
            Client owner = new Client (ownerDeal.Id, ownerDeal.FirstName, ownerDeal.LastName, ownerDeal.Email);
            LocationWrapper locationWrapper = new LocationWrapper(pCountry, pCity, pAddress, pLatitude, pLongitude);
            Property property = new Property(pId, owner, locationWrapper);

            Info info = new Info(dt, sd, ed, client, property);

        return JSON.serialize(info);
    }
     

}
