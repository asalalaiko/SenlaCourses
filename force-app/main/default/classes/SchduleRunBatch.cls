global class SchduleRunBatch  implements Schedulable {
    global void execute(SchedulableContext ctx) {
        GetEndedLeaseDealsToPlatformEvents b = new GetEndedLeaseDealsToPlatformEvents();
          database.executeBatch(b);
     }   
}

//Code to run schedule
// SchduleRunBatch s = new SchduleRunBatch();
// String expression='0 0 6 * * ? *';
// System.Schedule('Notify the contacts one day before the end of the rental', expression, s);