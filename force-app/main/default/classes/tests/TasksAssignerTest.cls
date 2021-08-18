@isTest
public class TasksAssignerTest {
    @isTest
    public static void testAssignTasksToUser(){
        Integer recordsCount = 5;
        List<Account> accounts = TestDataFactory.ACCOUNTF.createAccounts(recordsCount, true);
        List<Task> tasks = [SELECT WhatId FROM Task];
        List<User> users = [SELECT Name FROM User WHERE IsActive = true];
        for(Integer i = 0; i < recordsCount; i++){
            tasks.get(i).WhatId = accounts.get(0).Id;
            tasks.get(i).OwnerId = users.get(Math.mod(i, users.size())).Id;
        }
        update tasks;
        Test.startTest();
        update accounts;
        Test.stopTest();
        List<Task> updatedTasks = [SELECT OwnerId FROM Task];
        Set<Id> ownerIds = new Set<Id>();
        for(Task task : updatedTasks){
            ownerIds.add(task.OwnerId);
        }
        System.assertEquals(1, ownerIds.size());
    }
}
