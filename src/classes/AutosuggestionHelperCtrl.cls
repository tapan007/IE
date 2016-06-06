public class AutosuggestionHelperCtrl{
    public  String suggestion {get;set;}
    public  String suggestionBodyId {get;set;}
    public  String suggestionBody {get;set;}
    public AutosuggestionHelperCtrl(){
        suggestion ='';
        suggestionBodyId ='';
        suggestionBody  = '';
    }
    public void getSuggestion(){
        string searchword = ApexPages.currentPage().getParameters().get('searchword');
        searchword = searchword.substring(1);
        searchword  = '%'+searchword +'%';
        system.debug('###searchword '+searchword );
        list<Email_Template__c> lst = [select id,Name from Email_Template__c where Name like :searchword limit 10 ];
        suggestion  = String.escapeSingleQuotes(JSON.serialize(lst));
    }
     public void getSuggestionBody(){
        suggestionBodyId = ApexPages.currentPage().getParameters().get('id');
        //suggestionBodyId = suggestionBodyId.substring(1);
        list<Email_Template__c> lst = [select id,Name,EmailBody__c from Email_Template__c where Id =:suggestionBodyId limit 1];
        if(lst  != null && lst.size() > 0){
          suggestionBody =  lst[0].EmailBody__c ;
        }
        
    }
}