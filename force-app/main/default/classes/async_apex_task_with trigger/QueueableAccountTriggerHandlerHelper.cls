public with sharing class QueueableAccountTriggerHandlerHelper implements Queueable {
    private List<Id> ids;
    public QueueableAccountTriggerHandlerHelper() {

    }
    public QueueableAccountTriggerHandlerHelper(List<id> ids) {

        this.ids = ids; 
    }
    public void execute(QueueableContext context){
        List<Contact> contacts = [SELECT Id FROM Contact WHERE AccountId IN : ids];
        for(Contact con : contacts){
            con.Is_Synced__c = false;
            con.Processed_By_Queue__c = true;
        }
        update contacts;
    }
}
