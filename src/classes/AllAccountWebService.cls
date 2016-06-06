@RestResource(urlMapping='/getAccounts/*') 
global class AllAccountWebService {
    @HttpPost
    global static List<Account> getAccounts()
    {
        List<Account> acntlst;
        RestContext.response.addHeader('Access-Control-Allow-Origin', '*');
         RestContext.response.addHeader('Access-Control-Request-Method', 'POST');
         RestContext.response.addHeader('Content-type', 'application/json');
          RestContext.response.addHeader('Access-Control-Allow-Headers', '*');
           RestContext.response.addHeader('Access-Control-Max-Age', '1728000');
        try{
            
            acntlst = [select name,AccountSource from Account limit 5];
            return acntlst;
        }
        catch(Exception ex){
            system.debug('ERROR:' + ex.getMessage());
        }
        return acntlst;
    }
    @HttpGet
    global static string getResponseTime(){
        DateTime starts= System.now();
        Integer i;
        for(i=0;i<10000;i++){
            system.debug('hello'+i);
        }
        DateTime ends = System.now();
        //return (ends.getTime() - starts.getTime());
        string str = '{"message":"hello","url":"https://www.sf.com?id=hell&how=5"}';
        
        result re = new result();
        re.msg = 'message';
        re.url='https://www.sf.com?id=hell&how=5';
        //return re;
        return str;
        
    }
    global class result{
        string msg;
        string url;
    }
}