public with sharing class CreateOrder {
    
    @AuraEnabled
    public static Order newOrder(Order ord){
        try {
                insert ord;
                return ord;
            
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
}
