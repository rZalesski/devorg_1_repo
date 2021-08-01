public with sharing class TasksCreator {
    public TasksCreator() {

    }
    @InvocableMethod
    public static void createNewTasks(List<Id> ids){
        Map<Id, Account> accounts = new Map<Id, Account>([
            SELECT Name FROM Account WHERE Id IN : ids
        ]);
        List<Task> tasks = new List<Task>();
        for(Id accId : ids){
            tasks.add(new Task(Subject = 'Negotiations with ' + accounts.get(accId).Name, WhatId = accId));
        }
        insert tasks;
    }
}
