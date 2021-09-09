trigger AccountTrigger on Account (
    before update, before insert, before delete, after update, after insert, after delete, after undelete
) {
    AccountTriggerHandler handler = new AccountTriggerHandler();
    handler.handleAction(Trigger.new, Trigger.newMap, Trigger.old, Trigger.oldMap);
}