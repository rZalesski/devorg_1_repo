@isTest
public class AccountAndContactHandlerWithFutureTest {
    @isTest
    public static void testUpdateContacts(){
        Integer num = 5;
        TestDataFactory.CONTACTF.createContactsRelatedToAccounts(num, true);
        Test.startTest();
        AccountAndContactHandlerWithFuture.updateContacts();
        Test.stopTest();
        List<Contact> contacts = [SELECT Is_Synced__c, Processed_By_Future__c FROM Contact];
        for(Contact con : contacts){
            System.assertEquals(false, con.Is_Synced__c);
            System.assertEquals(true, con.Processed_By_Future__c);
        }
        System.assertEquals(num, contacts.size());
    }
}

