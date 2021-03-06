public with sharing class TasksAssigner {
    @InvocableMethod
    public static void assignTasksToUser(List<Id> ids){        
        List<Task> tasks = new List<Task>([
            SELECT WhatId FROM Task WHERE WhatId IN : ids 
        ]);
        List<User> users = new List<User>([
            SELECT Id FROM User WHERE IsActive = true AND Name <> 'Chatter Expert'
        ]);
        Map<Id, Integer> idIntMap = new Map<Id, Integer>();
        for(Task task : tasks){
            idIntMap.put(
                task.WhatId, 
                idIntMap.get(task.WhatId) == null ? 1 : idIntMap.get(task.WhatId) + 1
            );
        }
        Map <Id, Id> userIdsMap = new Map<Id, Id>();
        for(Task task : tasks){
            if(idIntMap.get(task.WhatId) > 3){
                userIdsMap.put(
                    task.WhatId, 
                    userIdsMap.get(task.WhatId) == null ? 
                    users.get((Integer)(Math.random()*users.size())).Id : 
                    userIdsMap.get(task.WhatId)
                );
                task.OwnerId = userIdsMap.get(task.WhatId);
            } 
        }
        update tasks;
    }
}