public with sharing class CreateOrder {
    @AuraEnabled
    public static void newOrder(String acct, String ship, String state , Date day ){
        try {
            Order ord = new Order();
            ord.AccountId = acct;
            ord.ShipToContactId = ship;
            ord.Status = state;
            ord.EffectiveDate = day;
            insert ord;
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
}
