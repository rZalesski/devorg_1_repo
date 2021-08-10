public with sharing class BatchableJobOnAccountWithIterable 
implements Database.Batchable<SObject> {
    public Iterable<SObject> start(Database.BatchableContext context){
        return [SELECT AccountId FROM Contact WHERE Is_Synced__c = false];
    }
    public void execute(Database.BatchableContext context, List<Contact> contacts){
        Set<Id> accountIds = new Set<Id>();
        for(Contact contact : contacts){
            accountIds.add(contact.AccountId);
        }
        Map<Id, Account> accountsMap = new Map<Id, Account>([
            SELECT BillingStreet, BillingCity, BillingState, BillingPostalCode, BillingCountry, BillingLatitude, BillingLongitude
            FROM Account 
            WHERE Id IN : accountIds
        ]);
        for(Contact contact : contacts){
            if(accountsMap.get(contact.AccountId) == null){
                continue;
            }
            contact.MailingStreet = accountsMap.get(contact.AccountId).BillingStreet; 
            contact.MailingCity = accountsMap.get(contact.AccountId).BillingCity; 
            contact.MailingState = accountsMap.get(contact.AccountId).BillingState;
            contact.MailingPostalCode = accountsMap.get(contact.AccountId).BillingPostalCode; 
            contact.MailingCountry = accountsMap.get(contact.AccountId).BillingCountry; 
            contact.MailingLatitude = accountsMap.get(contact.AccountId).BillingLatitude; 
            contact.MailingLongitude = accountsMap.get(contact.AccountId).BillingLongitude;
            contact.Is_Synced__c = true;
            accountsMap.get(contact.AccountId).Updated_By_Contact__c = true;
        }
        update contacts;
        update accountsMap.values();
    }
    public void finish(Database.BatchableContext context){
        System.debug('one batch completed');
    }
}
