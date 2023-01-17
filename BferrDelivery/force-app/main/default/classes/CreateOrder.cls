public with sharing class CreateOrder {
    @AuraEnabled
    public static void newOrder(String acct, String ship, String state , Date day, String Prod){
       OrderItem Menu = new OrderItem();
        Order ord = new Order();
            
        
        try {  
            ord.AccountId = acct;
            ord.ShipToContactId = ship;
            ord.Status = state;
            ord.ExternalId__c = '5243' ;
            ord.EffectiveDate = day;
            ord.Pricebook2Id= '01s68000001W8GKAA0';
        
            insert ord;
            
       } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
            }
           
            try { 
                List<PriceBookEntry> Prezzo =[SELECT Id,UnitPrice FROM PricebookEntry WHERE  Product2Id =: Prod  ];
            Menu.UnitPrice= Prezzo[0].UnitPrice;
            Menu.PricebookEntryId=Prezzo[0].Id;
            Menu.Product2Id = Prod;
            Menu.Quantity = 1;
            Menu.OrderId = ord.Id;
                insert Menu;
                
            } catch (Exception e) {
                throw new AuraHandledException(e.getMessage());
            }
    }
   
}