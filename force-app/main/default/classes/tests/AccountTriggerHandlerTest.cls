@isTest
public class AccountTriggerHandlerTest {
    private static Integer recordsNum = 5;
    @TestSetup
    static void makeData(){
        List<Contact> cons = TestDataFactory.CONTACTF.createContactsRelatedToAccounts(recordsNum, true);
        for(Contact con : cons){
            con.Is_Synced__c = true;
        }
        update cons;
    }
    @isTest
    public static void testBeforeUpdate(){
        List<Account> accounts = [SELECT Id FROM Account];
        for(Account acc : accounts){
            acc.BillingStreet = 'qwerty';
            acc.BillingCity = 'qwerty';
            acc.BillingState = 'qwerty';
            acc.BillingCountry = 'qwerty';
            acc.BillingPostalCode = 'asdfg12345';
            acc.BillingLatitude = 15;
            acc.BillingLongitude = 15;
        }
        Test.startTest();
        update accounts;
        Test.stopTest();
        for(Contact con : [
            SELECT is_Synced__c, Processed_By_Future__c, Processed_By_Queue__c 
            FROM Contact
        ]){
            System.assertEquals(true, con.Processed_By_Queue__c);
            System.assertEquals(true, con.Processed_By_Future__c);
            System.assertEquals(false, con.is_Synced__c);        
        }
    }
    @isTest
    public static void testBeforeUpdateWithSameAddresses(){
        List<Account> accounts = [SELECT Id FROM Account];
        Test.startTest();
        update accounts;
        Test.stopTest();
        for(Contact con : [
            SELECT is_Synced__c, Processed_By_Future__c, Processed_By_Queue__c 
            FROM Contact
        ]){
            System.assertEquals(false, con.Processed_By_Queue__c);
            System.assertEquals(false, con.Processed_By_Future__c);
            System.assertEquals(true, con.is_Synced__c);        
        }
    }
    @isTest
    public static void testAfterInsert(){
        Test.startTest();
        TestDataFactory.ACCOUNTF.createAccounts(recordsNum, true);
        Test.stopTest();
        List<Task> tasks = [SELECT Is_Synced__c FROM Task];
        System.assertEquals(recordsNum * 2, tasks.size());
        for(Task task : tasks){
            System.assertEquals(task.Is_Synced__c, false);
        }
    }
}
