public with sharing class CreateOrder {
    @AuraEnabled
<<<<<<< HEAD
    public static newOrder(String input){
=======
    public static void newOrder(String acct, String ship, String state, Date day ){
>>>>>>> de93a4010d0d82a391778c2d7d9e5949b2f0ff00
        try {
            Order ord = new Order();
            ord.AccountId = acct;
            ord.ShipToContactId = ship;
            ord.Status = state;
            ord.EffectiveDate = day;
            ord.ExternalID__c = 5243;
            insert ord;
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
}
