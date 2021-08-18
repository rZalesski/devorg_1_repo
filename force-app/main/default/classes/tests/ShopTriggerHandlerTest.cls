@isTest
public class ShopTriggerHandlerTest {
    private static Integer recordsNum = 5;
    @TestSetup
    static void makeData(){
        TestDataFactory.SHOPF.createShopsRelatedToCorps(recordsNum, true);
    }
    @isTest
    public static void testBeforeUpdate(){
        List<Shop__c> shops = [SELECT Name FROM Shop__c];
        Test.startTest();
        update shops;
        Test.stopTest();
        System.debug([SELECT Name FROM Shop__c]);
        List<Shop__c> updatedShops = [
            SELECT Name
            FROM Shop__c
            WHERE Name LIKE '%(old)%'
        ];
        System.assertEquals(recordsNum, updatedShops.size());
        

    }
    @isTest
    public static void testBeforeInsert(){
        Test.startTest();
        List<Shop__c> shops = TestDataFactory.SHOPF.createShopsRelatedToCorps(recordsNum, true);
        Test.stopTest();
        List<Shop__c> newShops = [
            SELECT Name 
            FROM Shop__c 
            WHERE Name LIKE '%*handled by trigger*%'
        ];
        System.assertEquals(recordsNum * 2, newShops.size());
    }
}
