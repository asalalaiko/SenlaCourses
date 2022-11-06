public with sharing class Callouts {
    
    public static HttpResponse getCountyCodes() {
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://pkgstore.datahub.io/core/country-list/data_json/data/8c458f2d15d9f2119654b29ede6e45b8/data_json.json');
        request.setMethod('GET');
        HttpResponse response = http.send(request);
        return response;
    }

    
}