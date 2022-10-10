global class SchduleRunBatchEndedLeaseDeals  implements Schedulable {
    global void execute(SchedulableContext ctx) {
          BatchEndedLeaseDeals b = new BatchEndedLeaseDeals();
          database.executeBatch(b);
     }   
}

//Code to run schedule
// SchduleRunBatchEndedLeaseDeals s = new SchduleRunBatchEndedLeaseDeals();
// String expression='0 0 6 * * ? *';
// System.Schedule('Notify the contacts one day before the end of the rental', expression, s);