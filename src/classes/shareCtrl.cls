public with sharing class shareCtrl {
public list<share__c> listshare{get;set;}
    public shareCtrl(){
      listshare = new list<share__c> ();
      listshare = [select id,Name,Email__c,Phone_no__c from share__c];
      system.debug('###listshare'+listshare );
      Apexpages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO,'' + listshare ));
    }
}