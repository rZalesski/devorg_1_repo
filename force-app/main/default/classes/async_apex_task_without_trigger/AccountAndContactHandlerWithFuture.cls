public with sharing class AccountAndContactHandlerWithFuture {
    public AccountAndContactHandlerWithFuture() {

    }
    @future
    public static void updateContacts(){
        Map<Id, Account> accountsMap = new Map<Id, Account>([
            SELECT BillingStreet, BillingCity, BillingState, BillingPostalCode, BillingCountry, BillingLatitude, BillingLongitude
            FROM Account
            WHERE (BillingStreet <> NULL AND BillingStreet <> '')
            OR (BillingCity <> NULL AND BillingCity <> '')
            OR (BillingState <> NULL AND BillingState <> '')
            OR (BillingPostalCode <> NULL AND BillingPostalCode <> '')
            OR (BillingCountry <> NULL AND BillingCountry <> '')
            OR (BillingLatitude <> NULL AND BillingLatitude <> 0)
            OR (BillingLongitude <> NULL AND BillingLongitude <> 0)
            LIMIT 150
        ]);
        List<Contact> contacts = [
            SELECT Id 
            FROM Contact 
            WHERE AccountId IN : accountsMap.keySet()
            ];
        for(Contact con : contacts){
            con.Is_Synced__c = false;
            con.Processed_By_Future__c = true;
        }
        update contacts;
    }
}