public with sharing class OrderCallout {
    @future(callout=true)
        public static void newOrderCallout(String input) {
            Http http = new Http();
            HttpRequest request = new HttpRequest();
            request.setEndpoint('https://63bbd5bd32d17a509099c273.mockapi.io/Orders');
            request.setMethod('POST');
            request.setHeader('Content-Type', 'application/json;charset=UTF-8');
            request.setBody(input);
            HttpResponse response = http.send(request);
            // Parse the JSON response
            if(response.getStatusCode() == 201) {
                System.debug(response.getBody());
                StrutturaOrdine so = (StrutturaOrdine)JSON.deserialize(response.getBody(),StrutturaOrdine.class);
                System.debug('Struttura deserializzata' + so.externalId);
                //query su externalId e update status
                List<Order> OrdineConfermato = [SELECT Id, Status, ExternalId__C FROM Order WHERE ExternalId__c LIKE : so.externalId];
                for(Order con: OrdineConfermato){
                con.Status = 'Ordine in preparazione';
                update con;
             }
            } else {
                System.debug('The status code returned was not expected: ' +
                    response.getStatusCode() + ' ' + response.getStatus());
            }
            //return response;
        }

    public class StrutturaOrdine{
        @AuraEnabled
        public String message;
        @AuraEnabled
        public String externalId;
    }    
}   

