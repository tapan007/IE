public class AutomaticProperty {



    integer MyReadOnlyProp ;
    public double MyReadWriteProp { get; set; }
    public string MyWriteOnlyProp { set; }
    public AutomaticProperty(){
        system.debug('hello inside constructor');
    }
    public void debug(){
        MyReadOnlyProp = 5;
    }
    {
        system.debug('hello outside constructor');
    }
}