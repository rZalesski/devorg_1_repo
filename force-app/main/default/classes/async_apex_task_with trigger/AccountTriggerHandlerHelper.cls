public with sharing class AccountTriggerHandlerHelper {
    @future
    public static void afterInsertFuture(Set<Id> idsSet){
        List<Task> tasks = [SELECT Id FROM Task WHERE WhatId IN : idsSet];
        for(Task task : tasks){
            task.Is_Synced__c = false;
        }
        update tasks;
    }
    public static void beforeUpdate(Map<Id, Account> newAccountsMap, Map<Id, Account> oldAccountsMap){
        List<Id> accountIds = new List<Id>();
        for(Account acc : newAccountsMap.values()){
            if(!compareBillingAddresses(oldAccountsMap.get(acc.Id), acc)){
                accountIds.add(acc.Id);
            }
        }
        beforeUpdateFuture(accountIds);
        beforeUpdateQueue(accountIds);
    }
    @future
    private static void beforeUpdateFuture(List<Id> ids){
        List<Contact> contacts = [SELECT Id FROM Contact WHERE AccountId IN : ids];
        for(Contact con : contacts){
            con.Is_Synced__c = false;
            con.Processed_By_Future__c = true;
        }
        update contacts;
    }
    private static void beforeUpdateQueue(List<Id> ids){
        QueueableAccountTriggerHandlerHelper qHelper = 
        new QueueableAccountTriggerHandlerHelper(ids);
        Id jobId = System.enqueueJob(qHelper);
    }
    public static Boolean compareBillingAddresses(Account oldAccount, Account newAccount){
        if(
            newAccount.BillingStreet != oldAccount.BillingStreet || 
            newAccount.BillingCity != oldAccount.BillingCity || 
            newAccount.BillingState != oldAccount.BillingState || 
            newAccount.BillingPostalCode != oldAccount.BillingPostalCode|| 
            newAccount.BillingCountry != oldAccount.BillingCountry || 
            newAccount.BillingLatitude != oldAccount.BillingLatitude || 
            newAccount.BillingLongitude != oldAccount.BillingLongitude){
                return false;
            }
            return true;
    }
}