@RestResource(urlMapping = '/AccountAPI/*')
global with sharing class AccountRestService {
    @HttpGet
    global static List<Account> getAccounts() {
        RestRequest request = RestContext.request;
        String nameLike = '%' + request.requestURI.substring(
            request.requestURI.lastIndexOf('/') + 1
        ) + '%';
        return [SELECT Name FROM Account WHERE Name LIKE : nameLike];
    }
    @HttpPost
    global static List<Account> createAccounts(){
        RestRequest request = RestContext.request;
        List<Account> accounts = 
        (List<Account>)JSON.deserialize(
            request.requestBody.toString(), List<Account>.class
        );
        for(Account acc : accounts){
            acc.Description = '[Handled by POST method]';
        }
        insert accounts;
        return accounts;
    }
    @HttpDelete
    global static List<Account> deleteAccounts(){
        RestRequest request = RestContext.request;
        List<Account> accounts = 
        (List<Account>)JSON.deserialize(
            request.requestBody.toString(), List<Account>.class
        );
        delete accounts;
        return accounts;    
    }
    @HttpPut
    global static List<Account> upsertAccounts(){
        RestRequest request = RestContext.request;
        List<Account> accounts = 
        (List<Account>)JSON.deserialize(
            request.requestBody.toString(), List<Account>.class
        );
        for(Account acc : accounts){
            acc.Description = '[Handled by PUT method]';
        }
        upsert accounts;
        return accounts; 
    }
    @HttpPatch
    global static List<Account> updateAccounts(){
        RestRequest request = RestContext.request;
        List<Account> accounts = 
        (List<Account>)JSON.deserialize(
            request.requestBody.toString(), List<Account>.class
        );
        for(Account acc : accounts){
            acc.Description = '[Handled by PATCH method]';
        }
        update accounts;
        return accounts; 
    }
}
