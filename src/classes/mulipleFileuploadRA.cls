global with sharing class mulipleFileuploadRA {
	
	public  String description{get;set;}
	public String parentIdDoc{get;set;}
	public map<Id,Attachment>  attachmentsById{get;set;}
	public String documentId {get;set;}
	
	@RemoteAction
    global static String attachBlob(String parentId, String attachmentId, String fileName, String contentType, String base64BlobValue,String description){
        /*
        parentId: The sfdc object Id this file will be attached to
        attachmentId: The record of the current Attachment file being processed
        fileName: Name of the attachment
        contentTye: Content Type of the file being attached
        base64BlobValue: Base64 encoded string of the file piece currently processing
        */
               
        //If recordId is blank this is the first part of a multi piece upload
        if(attachmentId == '' || attachmentId == null){
            Attachment att = new Attachment(
                ParentId = parentId, 
                Body = EncodingUtil.Base64Decode(base64BlobValue),
                Name = fileName,
                ContentType = contentType,
                Description = description
            );
            insert att;
            
            //Return the new attachment Id
            return att.Id;
            
        }else{
            for(Attachment atm : [select Id, Body from Attachment where Id = :attachmentId]){
                //Take the body of the current attachment, convert to base64 string, append base64 value sent from page, then convert back to binary for the body
                update new Attachment(Id = attachmentId, Body = EncodingUtil.Base64Decode(EncodingUtil.Base64Encode(atm.Body) + base64BlobValue));
            }
            
            //Return the Id of the attachment we are currently processing
            return attachmentId;
        }
    }
    @RemoteAction
    global static String deleteAtttachment(String attachmentId){
        //If recordId is blank this is the first part of a multi piece upload
        if(attachmentId != '' || attachmentId != null){
           list<Attachment> atmlist =  [select Id from Attachment where Id = :attachmentId];
           if(atmlist != null && atmlist.size() > 0){
           		delete atmlist;
           		return 'sucess';
           }
  		}
  		return null;
    }
}