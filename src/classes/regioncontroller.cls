public class regioncontroller {
    public String name { get; set; }
    public String job { get; set; }
    public void save(){
        system.debug('###name'+name +job);
    }
}