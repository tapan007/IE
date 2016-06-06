public without sharing class deleteDemo {

    public void dodelete(){
        Id demoid = apexpages.currentpage().getparameters().get('id');
        demo__c demo = new demo__c(id = demoid );
        delete demo;
    }
}