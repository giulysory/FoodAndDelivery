public with sharing class CreateOrder {

    @AuraEnabled
    public static newOrder(String input){
        try {
            List<Account> la = [select Id, Name from Account WHERE Name='Edge Communications'];
            List<Contact> cnt = [select Id, Account.Name, Name from Contact WHERE Account.Name='Edge Communications'];
            Order ord = new Order();
            ord.Status = input;
            ord.AccountId = la[0].Id;
            ord.ShipToContactId = cnt[0].Id;
            insert ord;

        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
}
