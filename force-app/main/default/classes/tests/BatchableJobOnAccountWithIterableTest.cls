@isTest
public class BatchableJobOnAccountWithIterableTest {
    @isTest
    public static void testExecute(){
        Integer num = 5;
        TestDataFactory.CONTACTF.createContactsRelatedToAccounts(num, true);
        BatchableJobOnAccountWithIterable batch = new BatchableJobOnAccountWithIterable();
        Test.startTest();
        Database.executeBatch(batch);
        Test.stopTest();
        Map<Id, Account> accMap = new Map<Id, Account>([
            SELECT BillingStreet, BillingCity, BillingState, BillingPostalCode, BillingCountry, BillingLatitude, BillingLongitude
            FROM Account
        ]);
        List<Contact> contacts = [
            SELECT AccountId, MailingStreet, MailingCity, MailingState, MailingPostalCode, MailingCountry, MailingLatitude, MailingLongitude, Is_Synced__c
            FROM Contact
        ];
        for(Contact con : contacts){
            System.assertEquals(accMap.get(con.AccountId).BillingStreet, con.MailingStreet);
            System.assertEquals(accMap.get(con.AccountId).BillingCity, con.MailingCity);
            System.assertEquals(accMap.get(con.AccountId).BillingState, con.MailingState);
            System.assertEquals(accMap.get(con.AccountId).BillingCountry, con.MailingCountry);
            System.assertEquals(
                accMap.get(con.AccountId).BillingPostalCode, con.MailingPostalCode
            );
            System.assertEquals(
                accMap.get(con.AccountId).BillingLatitude, con.MailingLatitude
            );
            System.assertEquals(
                accMap.get(con.AccountId).BillingLongitude, con.MailingLongitude
            );
            System.assertEquals(true, con.Is_Synced__c);
        }
        System.assertEquals(num, contacts.size());
    }
}
