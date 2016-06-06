public class createZendeskTicket{
     public list<String> toAddresses ;
     public String subject;
     public String htmlString;
     JsonToken jsontokenObject;
     public createZendeskTicket(){
     	HttpRequest req = new HttpRequest();
        // set up the HTTP request with a method, endpoint, header, and body
        req.setMethod('POST');
        // DON'T FORGET TO UPDATE THE FOLLOWING LINE WITH YOUR appid
        req.setEndpoint('https://earn1.zendesk.com/oauth/tokens');
        req.setHeader('Content-Type', 'application/json');
        req.setBody('{"grant_type": "password","client_id": "persistent","client_secret": "3aaa54d15735f74504115922e6060e298b083590b6cf3b10a33ca76cc16f4b81","scope": "read","username": "tapan_badajena@persistent.co.in","password": "Silu1990_1"}');    
        // create a new HTTP object
        Http http = new Http();
         HTTPResponse res = http.send(req);
        // debugging call, which you can check in console logs
        System.debug('+++Fulfillment service returned '+ res.getBody());
         jsontokenObject = (JsonToken)JSON.deserialize(res.getBody(), JsonToken.class);
         system.debug('+++object return'+jsontokenObject);
     	
     }
     public void ineligibleTicketRaise(){
         toAddresses = new list<String>();
        // toAddresses.add('tapan_badajena@persistent.co.in');
        toAddresses.add('support@earn1.zendesk.com');
        subject = 'Application is ineligible';
        htmlString = '#requester&nbsp;' + UserInfo.getUserEmail() + '<br>#status&nbsp;' + 'open' + '<br>#assignee&nbsp;'+UserInfo.getUserEmail()+'<br>this will make application ineligible';
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        mail.setToAddresses(toAddresses);
        mail.setSubject(subject);
        mail.setHtmlBody(htmlString);
        Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail }); 
     }
     public void apiTicketRaise(){
     	 
        
        
         HttpRequest req2 = new HttpRequest();
         req2.setMethod('POST');
          req2.setEndpoint('https://earn1.zendesk.com/api/v2/tickets.json');
          req2.setHeader('Content-Type', 'application/json');
          req2.setHeader('Authorization', jsontokenObject.token_type + ' ' + jsontokenObject.access_token);
          req2.setBody('{"ticket":{"requester": {"name": "The Customer","email": "tapan_badajena@persistent.co.in"},"subject": "Your application is ineligible","description":"from api class"}}');    
        // create a new HTTP object
       	 Http http2 = new Http();
         HTTPResponse res2 = http2.send(req2); 
          System.debug('+++is ticket raise '+ res2.getBody()); 
        
     }
  /*   public void sendEmailToList(){
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        mail.setToAddresses(toAddresses);
        mail.setSubject(subject);
        mail.setHtmlBody(setHtmlBody);
        Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
    } */
    public class JsonToken{
    	
		public String access_token;	//4def2331731a425ea7f72e8b05439902440f2e04e01ddf302863aec7e66148c2
		public String token_type;	//bearer
		public String scope;	//read
		
	}
		
 }