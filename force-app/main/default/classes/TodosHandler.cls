public with sharing class TodosHandler {
    @AuraEnabled(cacheable=true)
    public static List<Todo__c> getTodosByName(String key){
        String qKey = '%' + key + '%';
        return [SELECT Id, Name, Category__c, Priority__c, 
        Is_Done__c, Creation_Date__c, Description__c, Image_URL__c
        FROM Todo__c WHERE Name LIKE : qKey];
    }
}
