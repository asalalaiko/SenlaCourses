@RestResource(urlMapping='/propery/v1/*')
global class PropertyRestResource {


    private static String getPropertyByOwner(Id ownerId) {
        String fields = 'Id, Name, Country__c, City__c, Address__c, Latitude__c, Longitude__c';
      
        List<Property__c> properties = PropertyManager.getPropertyesByOwnerId(ownerId, fields);
       
        return JSON.serialize(properties, true);
    }
    
    private static String getPropertyByIdForPeriod(String propertyId, String startDate, String endDate, String dealTypeName) {
        String fields = 'Id, RecordType.DeveloperName, Transaction_amount__c' 
                                            + ', Contact_buyer__c'
                                            + ', Contact__r.Id'
                                            + ', Contact__r.FirstName'
                                            + ', Contact__r.LastName'
                                            + ', Contact__r.Email'
                                            + ', Property__c';
        System.debug(propertyId);
        System.debug(startDate);
        System.debug(endDate);
        System.debug(dealTypeName);
        Date startPeriod = Date.valueOf(startDate);
        Date endPeriod = Date.valueOf(endDate);
        System.debug(startPeriod);
        System.debug(endPeriod);
        List<Deal__c> deals = DealManager.getDealsByProperyAndTypeFromPeriod(Id.valueOf(propertyId), startPeriod, endPeriod, dealTypeName, fields);


        return JSON.serialize(new Wrappers.InfoDealsFromPeriodByProperty(startPeriod, endPeriod, deals), true);
    }

    @HttpGet
    global static void doGet() {

        RestRequest req = RestContext.request;
        RestResponse res = RestContext.response;
        res.addHeader('Content-Type', 'application/json');

        String path = req.requestURI.substringAfterLast('v1/');
        
        if (path.contains('by_owner')) {
            res.responseBody = Blob.valueOf(getPropertyByOwner(req.params.get('owner')));
            res.statusCode = 200;
            
        } else if (path.contains('report/')){

            res.responseBody = Blob.valueOf(getPropertyByIdForPeriod(path.substringAfterLast('report/').substringBefore('?'),
                                                                    req.params.get('startDate'),
                                                                    req.params.get('endDate'),
                                                                    req.params.get('dealType')));
            res.statusCode = 200;
            
        } else {
            res.statusCode = 404;
           

        }

    }

    @HttpPost
    global static void createProperty() {
        RestRequest req = RestContext.request;
        RestResponse res = RestContext.response;
        String path = RestContext.request.requestURI.substringAfterLast('v1/');
        if (path.contains('add')){

            Wrappers.PropertyPostWrapper wrapPost = (Wrappers.PropertyPostWrapper) JSON.deserialize(req.requestBody.toString(),
                                                                                                    Wrappers.PropertyPostWrapper.class);
            PropertyManager.PropertyWrapper wrap = new PropertyManager.PropertyWrapper();
            wrap.type = Utils.findRecordTypeByName(wrapPost.type);
            wrap.address = wrapPost.address;
            wrap.city = wrapPost.city;
            wrap.country = wrapPost.country;
            wrap.contact = Id.valueOf(wrapPost.ownerID);
            wrap.reptPrice = Decimal.valueOf(wrapPost.rentalPrice);
            wrap.sellingPrice = Decimal.valueOf(wrapPost.sellingPrice);
                    
            Property__c result = PropertyManager.createProperty(wrap, true);
            if (result.id!=null) {
                res.responseBody = Blob.valueOf(JSON.serialize(result));
                res.statusCode = 200;
            } else {
                res.statusCode = 500;}
            }
        }


    @HttpPut
    global static void updatePropertyOwner() {
        String fieldsContact = 'Id, FirstName, LastName, Email';
        String fieldsProperty = 'Id, Contact__c';

        RestRequest req = RestContext.request;
        RestResponse res = RestContext.response;

        Wrappers.PropertyPutWrapper wrapPut = (Wrappers.PropertyPutWrapper) JSON.deserialize(req.requestBody.toString(),
                                                                                            Wrappers.PropertyPutWrapper.class);

        Property__c propForUpdate = PropertyManager.getPropertyById(Id.valueOf(wrapPut.propertyId), fieldsProperty);
        Contact contactByID = ContactManager.getContactById(wrapPut.newOwner.sfId, fieldsContact);
        Contact contactByEmail = new Contact();

        if (ContactManager.getContactsByEmail(wrapPut.newOwner.email, fieldsContact).size() == 0){
            
            ContactManager.ContactWrapper contractW = new ContactManager.ContactWrapper();
            contractW.type = ContactManager.CONTACT_TYPE_PROPERTY_OWNER;
            contractW.firstName = wrapPut.newOwner.firstName;
            contractW.lastName = wrapPut.newOwner.lastName;
            contractW.email = wrapPut.newOwner.email;

            contactByEmail = ContactManager.createContact(contractW, true);

        } else{
            contactByEmail = ContactManager.getContactsByEmail(wrapPut.newOwner.email, fieldsContact).get(0);
        }       
            
        if (contactByID.Id != null ) {
            PropertyManager.PropertyWrapper wrapper = new PropertyManager.PropertyWrapper();
            wrapper.contact = wrapPut.newOwner.sfId;
            
            PropertyManager.updatePropertyByID(propForUpdate.Id, wrapper, true);
            res.statusCode = 200;

        } else if (contactByEmail.Id == null ) {
            res.responseBody = Blob.valueOf('Client not found!!');
            res.statusCode = 401;
        } else  {
            PropertyManager.PropertyWrapper wrapper = new PropertyManager.PropertyWrapper();
            wrapper.contact = contactByEmail.Id;

            PropertyManager.updatePropertyByID(propForUpdate.Id, wrapper, true);
            res.statusCode = 200;
        }

        }
       
 

    

    
}