@isTest
public class QueueableAccountAndContactHandlerTest {
    @isTest
    public static void testExecute(){
        Integer num = 5;
        TestDataFactory.CONTACTF.createContactsRelatedToAccounts(num, true);
        Test.startTest();
        System.enqueueJob(new QueueableAccountAndContactHandler());
        Test.stopTest();
        List<Contact> contacts = [SELECT Is_Synced__c, Processed_By_Queue__c FROM Contact];
        for(Contact con : contacts){
            System.assertEquals(false, con.Is_Synced__c);
            System.assertEquals(true, con.Processed_By_Queue__c);
        }
        System.assertEquals(num, contacts.size());
    }
}
