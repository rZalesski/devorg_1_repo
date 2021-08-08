public with sharing class ShopTriggerHandler {
    private String context;
    private static Set<String> bypassedHandlers;
    static{
        bypassedHandlers = new Set<String>();
    }
    public ShopTriggerHandler() {
        this.setTriggerContext();
    }
    private void setTriggerContext(){
        if(Trigger.isExecuting && Trigger.isBefore && Trigger.isUpdate){
            context = 'before_update';
        }
        if(Trigger.isExecuting && Trigger.isBefore && Trigger.isInsert){
            context = 'before_insert';
        }
    }
    public void handleAction(
        List<Shop__c> newShops, Map<Id, Shop__c> newShopsMap, 
        List<Shop__c> oldShops, Map<Id, Shop__c> oldShopsMap
    ){
        if(!bypassedHandlers.isEmpty()) {
            return;
        }
        switch on context{
            when 'before_update' {
                bypassedHandlers.add(context);
                List<Shop__c> newShopsList = new List<Shop__c>();
                for(Shop__c shop : oldShops){
                    newShopsList.add(new Shop__c(
                        Name = shop.Name + ' (old)', Monthly_Revenue__c = shop.Monthly_Revenue__c, 
                        Corporation__c = shop.Corporation__c, Director__c = shop.Director__c
                    ));
                }
                insert newShopsList;
            }
            when 'before_insert' {
                bypassedHandlers.add(context);
                for(Shop__c shop : newShops){
                    shop.Name = shop.Name + ' *handled by trigger*';
                }
            }
        }
    }
}
