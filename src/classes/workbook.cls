public class workbook
{
    public Map <String, Schema.SObjectType> schemaMap = Schema.getGlobalDescribe();
    public List<FieldDetails> lstfieldname{get;set;}
    public map<String,list<FieldDetails>> lstfieldnamebysobjectname{get;set;}
    public List <FieldDetails> fields {get{return lstfieldname;} set{lstfieldname =value;}}
    public List <SelectOption> objectNames{public get; private set;}
    public String[] selectedObjects {get; set;}
	public String xlsHeader{
    get{
        String strHeader = '';
        strHeader += '<?xml version="1.0"?>';
        strHeader += '<?mso-application progid="Excel.Sheet"?>';
        return strHeader;
    }
}
    // Intialize objectNames and fields
    
    public workbook() {
        objectNames = initObjNames();
        fields = new List<FieldDetails>();
        lstfieldnamebysobjectname = new map<String,list<FieldDetails>>();
    }
    // Populate SelectOption list -
    
    // find all sObjects available in the organization
    
    private List<SelectOption> initObjNames() {
        List<SelectOption> objNames = new List<SelectOption>();
        List<String> entities = new List<String>(schemaMap.keySet());
        entities.sort();
        for(String name : entities)
        objNames.add(new SelectOption(name,name));
        return objNames;
    }
    
    // Find the fields for the selected object
    
    public void showFields() {
    //fields.clear();
	    system.debug('$$$$$' + selectedObjects);
	    //list<String> selectedObjectList = new list<String>();
	   // selectedObjectList = selectedObjects.split(',');
	    //system.debug('###selectedObjectList'+ selectedObjectList);
	   // system.debug('###schemaMap'+ schemaMap);
	    
	    for(String selectedObject: selectedObjects){
	    	system.debug('###selectedObject'+ selectedObject);
	    	system.debug('###schemaMap.get(selectedObject)'+ schemaMap.get(selectedObject));
		    lstfieldname = new list<FieldDetails>();
		    Map <String, Schema.SObjectField> fieldMap = schemaMap.get(selectedObject).getDescribe().fields.getMap();
		    for(Schema.SObjectField sfield : fieldMap.Values())
		        {
		            schema.describefieldresult dfield = sfield.getDescribe();
		            system.debug('#######' + dfield );
		            FieldDetails field = new FieldDetails();
		            field.name = dfield.getname();
		            field.fieldtype = String.valueOf(dfield.getType());
		            field.label = dfield.getLabel();
		            field.isAccessible = dfield.isAccessible();
		            field.isCustom = dfield.isCustom();
		            field.isUpdateable = dfield.isUpdateable();
		            lstfieldname.add(field);
		            
		        }
	    	lstfieldnamebysobjectname.put(selectedObject,lstfieldname);
	    }
	    
   }        
    
    
    public class FieldDetails
    {
        public String label 		{get; set;}
        public String name 			{get; set;}
        public String fieldtype		 {get;set;}
        public Boolean isAccessible {get;set;}
        public Boolean isCustom		{get;set;}
        public Boolean isUpdateable	{get;set;}
    }
    public Pagereference exportAll(){
    	String sParams = System.JSON.serialize(selectedObjects);
    	
    	Pagereference page = new Pagereference('/apex/workbookexcelhelper');
    	page.getParameters().put('id',EncodingUtil.urlEncode(sParams,'UTF-8'));
    	page.setRedirect(true);
    	return page;
    }
    public Pagereference viewhtml(){
    	String sParams = System.JSON.serialize(selectedObjects);
    	
    	
    	Pagereference page = new Pagereference('/apex/workbookheplerpage');
    	page.getParameters().put('id',EncodingUtil.urlEncode(sParams,'UTF-8'));
    	page.setRedirect(true);
    	return page;
    }
   
}