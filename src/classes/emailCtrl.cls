public class emailCtrl{
public list<SelectOption> lst{get;set;}
    public emailCtrl(ApexPages.StandardController controller){
        lst = new list<selectOption>();
        lst.add(new SelectOption('Tapan','tapan_badajena@persistent.co.in'));
    }
}