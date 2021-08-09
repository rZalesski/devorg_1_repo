public with sharing class AccountTriggerHandler {
    private static String context;
    private static Set<String> bypassedHandlers;
    static{
        bypassedHandlers = new Set<String>();
    }
    public AccountTriggerHandler() {
        this.setTriggerContext();
    }
    private void setTriggerContext(){
        if(Trigger.isExecuting && Trigger.isBefore && Trigger.isUpdate){
            context = 'before_update';
        }
        if(Trigger.isExecuting && Trigger.isBefore && Trigger.isInsert){
            context = 'before_insert';
        }
        if(Trigger.isExecuting && Trigger.isAfter && Trigger.isInsert){
            context = 'after_insert';
        }
    }
    public void handleAction(
        List<Account> newAccounts, Map<Id, Account> newAccountsMap, 
        List<Account> oldAccounts, Map<Id, Account> oldAccountsMap
    ){
        if(!bypassedHandlers.isEmpty()){
            return;
        }
        switch on context{
            when 'before_update' {
                if(!System.isBatch()){
                    AccountTriggerHandlerHelper.beforeUpdate(newAccountsMap, oldAccountsMap);
                    bypassedHandlers.add(context);
                }
            }
            when 'after_insert' {
                AccountTriggerHandlerHelper.afterInsertFuture(Trigger.newMap.keySet());
                bypassedHandlers.add(context);
            }
        }
    }
}
