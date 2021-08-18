@isTest
public class BatchableJobOnAccountWithQLTest {
    @isTest
    public static void testExecute(){
        Integer num = 5;
        TestDataFactory.ACCOUNTF.createAccounts(num, true);
        BatchableJobOnAccountWithQL batch = new BatchableJobOnAccountWithQL();
        Test.startTest();
        Database.executeBatch(batch);
        Test.stopTest();
        Map<Id, Account> accMap = new Map<Id, Account>([SELECT Owner.Name FROM Account]);
        List<Task> tasks = [SELECT Account_Owner__c, Is_Synced__c, WhatId FROM Task];
        for(Task task : tasks){
            System.assertEquals(true, task.Is_Synced__c);
            System.assertEquals(accMap.get(task.WhatId).Owner.Name, task.Account_Owner__c);
        }
        System.assertEquals(num, tasks.size());
    }
}
