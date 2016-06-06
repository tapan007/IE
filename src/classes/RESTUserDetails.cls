@RestResource(urlMapping='/UserDetails/*')
global with sharing class RESTUserDetails{

    @HttpGet
      global static User getUser() {
        
         
        List<User> users = [SELECT Id,UserName,Email,ContactId,Contact.Name,LinkdIn__c,IsActive   FROM User WHERE IsActive = true and Id=:Userinfo.getUserID()];
        return users[0];
        
      }
}