public with sharing class TasksAssigner {
    public TasksAssigner() {

    }
    @InvocableMethod
    public static void assignTasksToUser(List<Id> ids){
        Map<Id, Account> accountsMap = new Map<Id, Account>([
            SELECT Name FROM Account WHERE Id IN : ids
        ]);
        List<Account> accounts = accountsMap.values();
        // Map<Id, Task> tasksMap = new Map<Id, Tasks>([
        //     SELECT WhatId, OwnerId FROM Task
        // ]);
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
        for(Id id : ids){
            if(idIntMap.get(id) != null){
                if(idIntMap.get(id) >= 3){
                    Id randomUserId = users.get((Integer)Math.random()*(users.size() - 1)).Id;
                    for(Task task : tasks){
                        if(task.WhatId == id){
                            task.OwnerId = randomUserId;
                        }
                    }
                }
            }
        }
        update tasks;
    }
}
