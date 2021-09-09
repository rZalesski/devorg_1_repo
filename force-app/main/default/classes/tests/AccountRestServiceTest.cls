@isTest
public class AccountRestServiceTest {
    private static Integer num = 5;
    @isTest
    public static void testGetAccounts(){
        List<Account> accounts = TestDataFactory.ACCOUNTF.createAccounts(num, true);
        RestRequest req = new RestRequest();
        req.requestURI = 
        'https://epam154-dev-ed.my.salesforce.com/services/apexrest/AccountAPI/';
        req.httpMethod = 'GET';
        RestContext.request = req;
        Map<Id, Account> accMap = new Map<Id, Account>(AccountRestService.getAccounts());
        for(Account acc : accounts){
            System.assertEquals(acc.Id, accMap.get(acc.Id).Id);
        }
        System.assertEquals(num, accMap.size());
    }
    @isTest
    public static void testInsertAccounts(){
        List<Account> accounts = TestDataFactory.ACCOUNTF.createAccounts(num, false);
        RestRequest req = new RestRequest();
        req.requestURI = 
        'https://epam154-dev-ed.my.salesforce.com/services/apexrest/AccountAPI/';
        req.httpMethod = 'POST';
        req.headers.put('Content-Type', 'application/json;charset=UTF-8');
        req.requestBody = Blob.valueOf(JSON.serialize(accounts));
        RestContext.request = req;
        List<Account> respAccs = AccountRestService.insertAccounts();
        for(Account acc : respAccs){
            System.assertNotEquals(null, acc.Id);
        }
        System.assertEquals(num, respAccs.size());
    }
    @isTest
    public static void testDeleteAccounts(){
        List<Account> accounts = TestDataFactory.ACCOUNTF.createAccounts(num, true);
        System.assertEquals(num, [SELECT Id FROM Account].size());
        RestRequest req = new RestRequest();
        req.requestURI = 
        'https://epam154-dev-ed.my.salesforce.com/services/apexrest/AccountAPI/';
        req.httpMethod = 'DELETE';
        req.headers.put('Content-Type', 'application/json;charset=UTF-8');
        req.requestBody = Blob.valueOf(JSON.serialize(accounts));
        RestContext.request = req;
        Map<Id, Account> accMap = new Map<Id, Account>(AccountRestService.deleteAccounts());
        for(Account acc : accounts){
            System.assertEquals(acc.Id, accMap.get(acc.Id).Id);
        }
        System.assertEquals(num, accMap.size());
        System.assertEquals(0, [SELECT Id FROM Account].size());

    }
    @isTest
    public static void testUpsertAccounts(){
        List<Account> accounts = TestDataFactory.ACCOUNTF.createAccounts(num, true);
        accounts.add(new Account(Name = 'ASDFG'));
        RestRequest req = new RestRequest();
        req.requestURI = 
        'https://epam154-dev-ed.my.salesforce.com/services/apexrest/AccountAPI/';
        req.httpMethod = 'PUT';
        req.headers.put('Content-Type', 'application/json;charset=UTF-8');
        req.requestBody = Blob.valueOf(JSON.serialize(accounts));
        RestContext.request = req;
        List<Account> upsAccs = AccountRestService.upsertAccounts();
        System.assertEquals(1, [SELECT Id FROM Account WHERE Name LIKE '%ASDFG%'].size());
        System.assertEquals(num + 1, upsAccs.size());
    }
    @isTest
    public static void estUpdateAccounts(){
        List<Account> accounts = TestDataFactory.ACCOUNTF.createAccounts(num, true);
        RestRequest req = new RestRequest();
        req.requestURI = 
        'https://epam154-dev-ed.my.salesforce.com/services/apexrest/AccountAPI/';
        req.httpMethod = 'PATCH';
        req.headers.put('Content-Type', 'application/json;charset=UTF-8');
        req.requestBody = Blob.valueOf(JSON.serialize(accounts));
        RestContext.request = req;
        Map<Id, Account> updAccs = new Map<Id, Account>(AccountRestService.updateAccounts());
        System.assertEquals(num, updAccs.size());
        for(Account acc : accounts){
            System.assertEquals(acc.Id, updAccs.get(acc.Id).Id);
        }
    }
}
