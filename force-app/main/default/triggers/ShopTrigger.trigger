trigger ShopTrigger on Shop__c (
    before insert, before update, before delete, after insert, after update, after delete, after undelete
) {
    ShopTriggerHandler handler = new ShopTriggerHandler();
    handler.handleAction(Trigger.new, Trigger.newMap, Trigger.old, Trigger.oldMap);
}