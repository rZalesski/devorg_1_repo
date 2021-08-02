public with sharing class TasksAssigner {
    public TasksAssigner() {

    }
    @InvocableMethod
    public static void assignTasksToUser(List<Id> ids){
        Map<Id, Account> accountsMap = new Map<Id, Account>([
            SELECT Name FROM Account WHERE Id IN : ids
        ]);
        List<Account> accounts = accountsMap.values();
        
        List<Task> tasks = new List<Task>([
            SELECT WhatId, OwnerId FROM Task
        ]);
        List<User> users = new List<User>([
            SELECT Id FROM User WHERE IsActive = true
        ]);
        Map<Id, Integer> idIntMap = new Map<Id, Integer>();
        for(Task task : tasks){
            idIntMap.put(
                task.WhatId, 
                idIntMap.get(task.WhatId) == null ? 0 : idIntMap.get(task.WhatId) + 1
            );
        }
        // for(Id id : ids){
        //     if(idIntMap.get(id) != null){
        //         if(idIntMap.get(id) > 3){
        //             Id randomUserId = users.get((Integer)(Math.random()*(users.size() - 1))).Id;
        //             for(Task task : tasks){
        //                 if(task.WhatId == id){
        //                     task.OwnerId = randomUserId;
        //                 }
        //             }
        //         }
        //     }
        // }
        Map <Id, Id> userIdsMap = new Map<Id, Id>();
        for(Task task : tasks){
            if(idIntMap.get(task.WhatId) != null){
                if(idIntMap.get(task.WhatId) > 3){
                    userIdsMap.put(task.WhatId, 
                    userIdsMap.get(task.WhatId) == null ? 
                    users.get((Integer)(Math.random()*(users.size() - 1))).Id : 
                    userIdsMap.get(task.WhatId));
                    task.OwnerId = userIdsMap.get(task.WhatId);
                }
            }
        }
        update tasks;
    }
}
