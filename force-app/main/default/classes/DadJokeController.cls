public with sharing class DadJokeController {

    @AuraEnabled(cacheable=false)
    public static String getDadJoke() {
        DadJoke dadjoke;
        try {
            dadjoke = getDadJokeFromWS();
            System.debug('dadjoke: ' + dadjoke);

        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
        return JSON.serialize(dadJoke);
    }


    public static Dadjoke getDadJokeFromWS() {

        //initiate http object
        Http http = new Http();

        //the obj to return
        Dadjoke dadJoke;
        
        //initiate http request
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://official-joke-api.appspot.com/random_joke');
        request.setMethod('GET');

        //send request and return response
        HttpResponse response = http.send(request);

        if(response.getStatusCode() == 200) {
            System.debug('response body ' + response.getBody());
            dadJoke = (DadJoke) JSON.deserialize(response.getBody(), DadJoke.class);
        } else {
            System.debug('The status code returned was not expected: ' + response.getStatusCode() + ' ' + response.getStatus());
        }
        return dadJoke;
    }

}