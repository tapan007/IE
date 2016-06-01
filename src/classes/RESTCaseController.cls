@RestResource(urlMapping='/FieldCase/*')

global with sharing class RESTCaseController {


    @HttpGet
  global static List<Case> getOpenCases() {

    
    List<Case> cases = [SELECT Id, Subject, Status, OwnerId, Owner.Name from Case limit 5];
    RestContext.response.addHeader('Access-Control-Allow-Origin', '*');
    RestContext.response.addHeader('Access-Control-Request-Methods', 'GET');
    RestContext.response.addHeader('Access-Control-Allow-Headers', 'X-PINGOTHER');
    RestContext.response.addHeader('Access-Control-Max-Age', '1728000');

    return cases;
     
  }

}