public with sharing class BI_PSPB_NotificationStatusExpiredSched implements Schedulable {
    public void execute(SchedulableContext context) {
        BI_PSPB_NotificationStatusExpiredBatch batch = new BI_PSPB_NotificationStatusExpiredBatch();
        Database.executeBatch(batch, 100);
    }
}