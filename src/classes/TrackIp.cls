public class TrackIp{
    
    public TrackIp(){
        Apexpages.currentPage().getHeaders().put('Access-Control-Allow-Origin','*');
    }
    public void createIp(){
        system.debug('hello');
        IPTracker__c tr = new IPTracker__c();
        //tr.IP_Address__c = ApexPages.currentPage().getParameters().get('ip');
         tr.IP_Address__c = Apexpages.currentpage().getHeaders().get('X-Salesforce-SIP');
        insert tr;

    }
}