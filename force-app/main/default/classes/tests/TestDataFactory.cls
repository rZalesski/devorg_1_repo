@isTest
public class TestDataFactory {
    public static AccountFactory ACCOUNTF;
    public static ContactFactory CONTACTF;
    public static ShopFactory SHOPF;
    static{
        ACCOUNTF = new AccountFactory();
        CONTACTF = new ContactFactory();
        SHOPF = new ShopFactory();
    }
    public class AccountFactory{
        public List<Account> createAccounts(Integer num, Boolean doInsert){
            List<Account> accounts = new List<Account>();
            for(Integer i = 0; i < num; i++){
                accounts.add(new Account(
                    Name = 'Testacc ' + i, 
                    BillingStreet = 'Teststreet ' + i,
                    BillingCity = 'Testcity ' + i, 
                    BillingState = 'Teststate ' + i,
                    BillingCountry = 'Testcountry ' + i,
                    BillingPostalCode = '' + i,
                    BillingLatitude = i,
                    BillingLongitude = i
                ));
            }
            if(doInsert){
                insert accounts;
            }
            return accounts;
        }
    }
    public class ContactFactory{
        public List<Contact> createContactsRelatedToAccounts(Integer num, Boolean doInsert){
            List<Account> accounts = new List<Account>();
            for(Integer i = 0; i < num; i++){
                accounts.add(new Account(
                    Name = 'Testacc with Contact ' + i, 
                    BillingStreet = 'Teststreet ' + i,
                    BillingCity = 'Testcity ' + i, 
                    BillingState = 'Teststate ' + i,
                    BillingCountry = 'Testcountry ' + i,
                    BillingPostalCode = '' + i,
                    BillingLatitude = i,
                    BillingLongitude = i
                ));
            }
            insert accounts;
            List<Contact> contacts = new List<Contact>();
            for(Integer i = 0; i < num; i++){
                contacts.add(
                    new Contact(LastName = 'Testcon ' + i, AccountId = accounts.get(i).Id, Is_Synced__c = false)
                );
            }
            if(doInsert){
                insert contacts;
            }
            return contacts;
        }
    }
    public class ShopFactory{
        public List<Shop__c> createShopsRelatedToCorps(Integer num, Boolean doInsert){
            List<Corporation__c> corps = new List<Corporation__c>();
            for(Integer i = 0; i < num; i++){
                corps.add(new Corporation__c(Name = 'Testcorp ' + i));
            }
            insert corps;
            List<Shop__c> shops = new List<Shop__c>();
            for(Integer i = 0; i < num; i++){
                shops.add(
                    new Shop__c(Name = 'Testshop ' + i, Corporation__c = corps.get(i).Id)
                );
            }
            if(doInsert){
                insert shops;
            }
            return shops;
        }
    }
}
    
