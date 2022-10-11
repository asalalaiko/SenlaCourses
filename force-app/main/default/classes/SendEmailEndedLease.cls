public class SendEmailEndedLease {
    private static final EmailTemplate EMAIL_TEMPLATE_DEFAULT = [Select id, Subject, Body From EmailTemplate Where Name = 'EndedLease - Default'];
    private static final EmailTemplate EMAIL_TEMPLATE_ENGLISH = [Select id, Subject, Body From EmailTemplate Where Name = 'EndedLease - English'];
    private static final EmailTemplate EMAIL_TEMPLATE_FRENCH = [Select id, Subject, Body From EmailTemplate Where Name = 'EndedLease - French'];
    
    
    public static void sendEmails(List<Id> ids){

        List<Messaging.SingleEmailMessage> emailList = new List<Messaging.SingleEmailMessage>();
        List<Contact> contacts = ContactManager.getContactsByIds(ids, 'Id, Languages__c');



        for (Contact c : contacts){
            Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();

            switch on c.Languages__c {
                when 'English' {
                    mail.setTemplateId(EMAIL_TEMPLATE_ENGLISH.Id);
                }
                when 'French' {
                    mail.setTemplateId(EMAIL_TEMPLATE_FRENCH.Id);
                }
                when else {
                    mail.setTemplateId(EMAIL_TEMPLATE_DEFAULT.Id);
                }
             }

          
            mail.setTargetObjectId(c.id);
            emailList.add(mail);
        }
        

        if(!emailList.isEmpty()){
            System.debug('##'+emailList);
            Messaging.sendEmail(emailList);
            

        }    
    }



}
