public with sharing class ajaxHelperCtrl {
 public String jsonString {get;set;}
 public ajaxHelperCtrl(){
    jsonString='';
    String q = ApexPages.currentPage().getParameters().get('q');
    system.debug('## addfaf#q'+q  );
    
 }
 public void getAccountDetails(){
    String q = ApexPages.currentPage().getParameters().get('q');
    system.debug('###q'+q);
    list<AccountWarpper> listAccountWarpper = new list<AccountWarpper>();
    if(q != null){
        
        for(Account act: [Select id,Name from Account where Name like :q]){
            
            listAccountWarpper.add(new AccountWarpper(act.Name,act.Id));
        }
        //if(listAccountWarpper.size() > 0){
            
        //}
    }
    jsonString = (String)Json.serializePretty(listAccountWarpper);
    system.debug('###jsonString'+jsonString);
    
 }
 public class AccountWarpper{
    public String text;
    public String id;
    public AccountWarpper(String text,String id){
        this.text= text;
        this.id = id;
    }
 }
}