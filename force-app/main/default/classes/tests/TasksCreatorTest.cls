@isTest
public class TasksCreatorTest {
    @isTest
    public static void testCreateNewTasks(){
        Integer accNum = 5;
        List<Account> accounts = new List<Account>();
        List<Id> ids = new List<Id>();
        for(Account acc : accounts){
            ids.add(acc.Id);
        }
        Test.startTest();
        accounts = TestDataFactory.ACCOUNTF.createAccounts(accNum, true);
        Test.stopTest();
        List<Task> tasks = [SELECT WhatId, Subject FROM Task];
        Map<Id, Account> accMap = new Map<Id, Account>();
        for(Account acc : accounts){
            accMap.put(acc.Id, acc);
        }
        System.assertEquals(accNum, tasks.size());
        for(Task task : tasks){
            System.assertEquals(
                'Negotiations with ' + accMap.get(task.WhatId).Name, task.Subject
            );
        }
    }
}
