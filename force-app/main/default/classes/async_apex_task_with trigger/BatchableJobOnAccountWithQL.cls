public with sharing class BatchableJobOnAccountWithQL 
implements Database.Batchable<SObject> {
    public Database.QueryLocator start(Database.BatchableContext context){
        return Database.getQueryLocator(
            'SELECT WhatId FROM Task WHERE Is_Synced__c = false'
        );
    }
    public void execute(Database.BatchableContext context, List<Task> tasks){
        Set<Id> accountIds = new Set<Id>();
        for(Task task : tasks){
            accountIds.add(task.WhatId);
        }
        Map<Id, Account> accountsMap = new Map<Id, Account>([
            SELECT Owner.Name FROM Account WHERE Id IN : accountIds
        ]);
        for(Task task : tasks){
            if(accountsMap.get(task.WhatId) == null){
                continue;
            }
            task.Account_Owner__c = accountsMap.get(task.WhatId).Owner.Name;
            task.Is_Synced__c = true;
            accountsMap.get(task.WhatId).Updated_By_Task__c = true;
        }
        update tasks;
        update accountsMap.values();
    }
    public void finish(Database.BatchableContext context){
        System.debug('one batch completed');
    }
}