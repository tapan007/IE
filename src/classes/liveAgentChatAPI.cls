/****
* This class is used for testing live chat using API calls.
*
*
*
*****/
public with sharing class liveAgentChatAPI{
    
    public static void getConnection(){
        HttpRequest req = new HttpRequest();
        string sessionEndPoint = 'https://d.la2c1.salesforceliveagent.com/chat/rest/System/SessionId';       
        req.setEndPoint(sessionEndPoint);
        req.setMethod('GET');
        req.setHeader('X-LIVEAGENT-API-VERSION', '32');  
        req.setHeader('X-LIVEAGENT-AFFINITY', 'null');          
        try{
            Http http = new Http();
            HttpResponse res = new HTTPResponse();
            res = http.send(req);
            System.debug('res---->' + res); 
            SessionDetail sD = (new SessionDetail()).parse(res.getBody());
            system.debug('----Response object--'+sD);
            
            
            HttpRequest reqchat = new HttpRequest();
            string chatEndPoint = 'https://d.la2c1.salesforceliveagent.com/chat/rest/Chasitor/ChasitorInit';     
            reqchat.setEndPoint(chatEndPoint);
            reqchat.setMethod('POST');
            reqchat.setHeader('X-LIVEAGENT-API-VERSION', '32');  
            reqchat.setHeader('X-LIVEAGENT-AFFINITY', sD.affinityToken); 
             //reqchat.setHeader('X-LIVEAGENT-AFFINITY', 'null');
            reqchat.setHeader('X-LIVEAGENT-SESSION-KEY', sD.key);  
            //reqchat.setHeader('X-LIVEAGENT-SEQUENCE', '1');
            reqchat.setHeader('Content-Type','application/json');
            //reqchat.setHeader('Access-Control-Allow-Origin','*');
            /**************************/
            
            String requestBody = '{'+
    '"organizationId": "00Di0000000ipfN",'+
    '"deploymentId": "572i0000000Ror4",'+
    '"buttonId": "573i0000000Rs5q",'+
    '"agentId": "005i00000025xGy",'+
    '"doFallback": true,'+
    '"sessionId": "'+ sD.id +'",'+
    '"userAgent": "Mozilla",'+
    '"language": "en_US",'+
    '"screenResolution": "2560x1440",'+
    '"visitorName": "Jon A.",'+
    '"prechatDetails": ['+
    '{'+
        '"label": "Email",'+
        '"value": "tapan_badajena@persistent.co.in",'+
        '"transcriptFields": ['+
            '"c__EmailAddress"'+
        '],'+
        '"displayToAgent": true'+
    '}'+
    '],'+
    '"prechatEntities":['+
    '{'+
        '"entityName":"Contact",'+
        '"entityFieldMaps":[{'+
            '"fieldName": "Email",'+
            '"label":"Email",'+
            '"doFind":true,'+
            '"isExactMatch": true,'+
            '"doCreate":true'+
            
        '}]'+
        '}],'+
    /*'"buttonOverrides": ['+
    '"573170000008OIA"'+
    '],'+*/
    '"receiveQueueUpdates": true,'+
    '"isPost": true'+
'}';

            system.debug('### RequestBody -------->>> '+requestBody);
            
            reqchat.setBody(requestBody);
            Http chathttp = new Http();
            HttpResponse Chatres = new HTTPResponse();
            
            Chatres = chathttp.send(reqchat);
            system.debug('---> chat res -- '+Chatres.getBody());
    }catch(Exception e){
            system.debug('Exception in getConection method for live chatt using APi ===>>' + e.getMessage() );
        }
    }
    private class SessionDetail{
        String id;  //241590f5-2e59-44b5-af89-9cae83bb6947
        String key; //f6c1d699-84c7-473f-b194-abf4bf7cccf8!b65b13c7-f597-4dd2-aa3a-cbe01e69f19c
        String affinityToken;   //73061fa0
        String clientPollTimeout;   //30
        SessionDetail parse(String json){
            return (SessionDetail) System.JSON.deserialize(json, SessionDetail.class);
        }
    }
}