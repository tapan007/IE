public class progressbar{
    public list<tableWrapper> tableWrapperlist{get;set;}
    public progressbar(){
        tableWrapperlist = new list<tableWrapper>();
        for(integer i=0;i<1000;i++){
           tableWrapperlist.add(new tableWrapper(i+1,i+2,i+3,i+4,i+5,i+6,i+7,i+8,i+9,i+10,i+11,i+12,i+13,i+14,i+15,i+16,i+17,i+18,i+19));
            i = i+20;
        }
        
    }

    public class tableWrapper{
        public integer str1 {get;set;}
        public integer str2 {get;set;}
        public integer str3 {get;set;}
        public integer str4 {get;set;}
        public integer str5 {get;set;}
        public integer str6 {get;set;}
        public integer str7 {get;set;}
        public integer str8 {get;set;}
        public integer str9 {get;set;}
        public integer str10 {get;set;}
        public integer str11 {get;set;}
        public integer str12 {get;set;}
        public integer str13 {get;set;}
        public integer str14 {get;set;}
        public integer str15 {get;set;}
        public integer str16 {get;set;}
        public integer str17 {get;set;}
        public integer str18 {get;set;}
        public integer str19 {get;set;}
        
        public tableWrapper(integer str1,integer str2,integer str3,integer str4,integer str5,integer str6,integer str7,integer str8,integer str9,integer str10,integer str11,integer str12,integer str13,integer str14,integer str15,integer str16,integer str17,integer str18,integer str19){
           this.str1 =str1;
           this.str2 =str2;
           this.str3 =str3;
           this.str4 =str4;
           this.str5 =str5;
           this.str6 =str6;
           this.str7 =str7;
           this.str8 =str8;
           this.str9 =str9;
           this.str10 =str10;
           this.str11 =str11;
           this.str12 =str12;
           this.str13 =str13;
           this.str14 =str14;
           this.str15 =str15;
           this.str16 =str16;
           this.str17 =str17;
           this.str18 =str18;
           this.str19 =str19;
           
           
        }
    }
}