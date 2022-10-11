@isTest
public class SchduleRunBatchEndedLeaseDealsTest {

    public static String CRON_EXP = '0 0 6 * * ? *';

    @isTest  
    static void testSchedule(){
        Test.startTest();
        String jobID = System.schedule('Remind property tenants', CRON_EXP, new SchduleRunBatchEndedLeaseDeals());
        CronTrigger ct = [SELECT TimesTriggered, NextFireTime FROM CronTrigger WHERE id = :jobID]; 

        
        Test.stopTest();
  
        System.assertEquals(Datetime.newInstance(Datetime.now().date(), Time.newInstance(6, 0, 0, 0)), 
                            ct.NextFireTime);   
    }
}
