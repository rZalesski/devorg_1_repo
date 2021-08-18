public with sharing class SchedulableJobOnAccount implements Schedulable {
    public void execute(SchedulableContext context){
        Database.executeBatch(new BatchableJobOnAccountWithQL());
        Database.executeBatch(new BatchableJobOnAccountWithIterable());
    }
}