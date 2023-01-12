public with sharing class OrderCallout {
    @future
        public static void newOrderCallout(String input) {
            Http http = new Http();
            HttpRequest request = new HttpRequest();
            request.setEndpoint('https://63bbd5bd32d17a509099c273.mockapi.io/Orders');
            request.setMethod('POST');
            request.setHeader('Content-Type', 'application/json;charset=UTF-8');
            request.setBody(input);
            HttpResponse response = http.send(request);
            // Parse the JSON response
            if(response.getStatusCode() != 201) {
                System.debug('The status code returned was not expected: ' +
                    response.getStatusCode() + ' ' + response.getStatus());
            } else {
                System.debug(response.getBody());
            }
        }
    }   