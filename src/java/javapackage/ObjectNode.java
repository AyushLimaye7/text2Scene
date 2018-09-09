package javapackage;

//import .*;

public class ObjectNode {
	public String Name;
	public String Type;
	public String Number;
        public int pos,x,y,z,flag;
	 
	public ObjectNode(String Name, String Type, String Number,int position) 
	    {
	        this.Name = Name;
	        this.Type = Type;
	        this.Number = Number;
                this.pos=position;
                this.x=0;
                this.y=0;
                this.z=0;
                this.flag=0;
                
	    }
        public ObjectNode(String Name) 
	    {
	        this.Name = Name;
	    }

}

