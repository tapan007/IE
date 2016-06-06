public with sharing class workbookhelpercls {
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
    public workbookhelpercls(){
        lstfieldnamebysobjectname = new map<String,list<FieldDetails>>();
        system.debug('###ApexPages raw data'+ApexPages.currentPage().getParameters().get('Id'));
        String jsonlist = EncodingUtil.urlDecode(ApexPages.currentPage().getParameters().get('Id'),'UTF-8');
        system.debug('###jsonlist after decode'+jsonlist);
        
        selectedObjects = (List<String>)System.JSON.deserialize(jsonlist, List<String>.class);  
        showFields();         
    }
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
                        if(field.fieldtype.equalsignorecase('REFERENCE')){
                          field.fieldtype = 'Lookup ' + String.valueOf( dfield.getReferenceTo() ) ;
                        }
                        field.label = dfield.getLabel();
                        field.isAccessible = dfield.isAccessible();
                        field.isCustom = dfield.isCustom();
                        field.isUpdateable = dfield.isUpdateable();
                        field.length= dfield.getLength();
                        lstfieldname.add(field);
                        
                    }
                lstfieldnamebysobjectname.put(selectedObject,lstfieldname);
            }
            
       } 
        public class FieldDetails
    {
        public String label         {get; set;}
        public String name          {get; set;}
        public String fieldtype      {get;set;}
        public Boolean isAccessible {get;set;}
        public Boolean isCustom     {get;set;}
        public Boolean isUpdateable {get;set;}
        public Integer length        {get;set;}
    }
}