public with sharing class MailchimpPOC {
	public String apikey{get;set;}
	
	public map<String,String> titleId {get;set;}
	public String title{get;set;}
	public String id {get;set;}
	public List<SelectOption> options {get;set;} 
	public String selectedValue{get;set;}
	public String message{get;set;}
	public String campaignName{get;set;}
	public String templateName{get;set;}
	public String subject{get;set;}
	public MailchimpPOC(){
		
		apikey='740d8305018b69075e55e78bc018dd6a-us3';
		titleId = new map<String,String>();
		options =  new List<SelectOption>();
		intializeData();
		createOption();
		
	}
	public void intializeData(){
	 system.debug('welcome');
	 Http http = new Http();
	 HttpRequest req = new HttpRequest();
     req.setEndpoint('https://us3.api.mailchimp.com/2.0/lists/list');
     req.setMethod('POST');
	 String body = 'apikey='+ EncodingUtil.urlEncode(apikey, 'UTF-8');
	 req.setBody(body);
     HTTPResponse res = http.send(req);
     JSONParser parserList = JSON.createParser(res.getBody());
     while (parserList.nextToken() != null) {
            if ((parserList.getCurrentToken() == JSONToken.FIELD_NAME) && 
                (parserList.getText() == 'id')){
               parserList.nextToken();
              	id = parserList.getText();
              	system.debug('+++id' +id );
                 while (parserList.nextToken() != null){
                 	 if ((parserList.getCurrentToken() == JSONToken.FIELD_NAME) && (parserList.getText() == 'name')){
	                 	   parserList.nextToken();
	                 	   title = parserList.getText();
	                 	   system.debug('+++title' +title );
	                 	   titleId.put(title,id);
	                 	   id='';
	                 	   title=''; 
	                 	   break;
                 	 }
                 }
                
                system.debug('+++json' +parserList.getText() );
            }
        }
        system.debug('+++map' + titleId);
    	
	}
	public void createOption(){
		 for (String title : titleId.keySet()) {
			options.add(new SelectOption(title,title));
         }
	}
	public void send(){
	system.debug('###' + selectedValue);
	String template_id =createTemplate(apiKey,templateName,message);
	String list_id = titleId.get(selectedValue);
	String cid = createCampaign(apiKey,list_id,template_id);
	Http httpsend = new Http();
	HttpRequest reqsend = new HttpRequest();
     reqsend.setEndpoint('https://us3.api.mailchimp.com/2.0/campaigns/send');
     reqsend.setMethod('POST');
	 String body = 'apikey='+ EncodingUtil.urlEncode(apikey, 'UTF-8')+'&cid=' + EncodingUtil.urlEncode(cid, 'UTF-8');
	 reqsend.setBody(body);
     HTTPResponse resSend = httpsend.send(reqsend);
     system.debug('###send status' + resSend.getBody() );
	}
	public String createTemplate(String apiKey,String name,String html){
		
		 Http httpAddTemp = new Http();
		 HttpRequest reqsend = new HttpRequest();
	     reqsend.setEndpoint('https://us3.api.mailchimp.com/2.0/templates/add');
	     reqsend.setMethod('POST');
	   	 String body = 'apikey='+ EncodingUtil.urlEncode(apikey, 'UTF-8')+'&name=' + EncodingUtil.urlEncode(name, 'UTF-8') + '&html=' + EncodingUtil.urlEncode(html, 'UTF-8');
		 reqsend.setBody(body);
	     HTTPResponse resSend = httpAddTemp.send(reqsend);
	     JSONParser parserList = JSON.createParser(resSend.getBody());
	      while (parserList.nextToken() != null){
	            if ((parserList.getCurrentToken() == JSONToken.FIELD_NAME) && (parserList.getText() == 'template_id')){
	            	parserList.nextToken();
	            	return parserList.getText();
	            	
	             }
	      }
	       return null;
		}
	public String createCampaign(String apiKey,String list_id,String template_id){
		
		 Http httpAddCamp = new Http();
		 HttpRequest reqsend = new HttpRequest();
	     reqsend.setEndpoint('https://us3.api.mailchimp.com/2.0/campaigns/create');
	     reqsend.setMethod('POST');
	   	 String body = '{"apikey": "740d8305018b69075e55e78bc018dd6a-us3","type": "regular","options": {"list_id": "'  + list_id + '","subject": "'+ subject + '","from_email": "tapan_badajena@persistent.co.in","from_name": "examplefrom_name","to_name": "exampleto_name","template_id":"' +  template_id + '","generate_text": "true"},"content": {"html":"' + message + '"}}';
	   	 
	   	 system.debug('body json'+ body);
	   	 
		 reqsend.setBody(body);
	     HTTPResponse resSend = httpAddCamp.send(reqsend);
	     JSONParser parserList = JSON.createParser(resSend.getBody());
	      while (parserList.nextToken() != null){
	            if ((parserList.getCurrentToken() == JSONToken.FIELD_NAME) && (parserList.getText() == 'id')){
	            	parserList.nextToken();
	            	return parserList.getText();
	            	
	             }
	      }
	       return null;
		}
		
	
}