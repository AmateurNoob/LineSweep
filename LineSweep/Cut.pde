/*
* Author: Brian Carlos Carbajal?*
*
* Adapted by: Chris Mason
*
* Provided Segment class, with added get() methods for RGB values
*/

class Cut{
    //private Segment next;
    //private Segment prev;
    private float x_val;
    private float y_source;
    private float y_sink;
    private int id_source;
    private int id_sink;
    
    public Cut(float x, float y1, float y2, int id1, int id2)
    {
        x_val = x;
        y_source = y1; 
        y_sink = y2;
        id_source = id1;
        id_sink = id2;
        
    }//END Constructor
    
    float getX(){
       return x_val; 
    }
    
    float getY1(){
      return y_source;
    }
    
    float getY2(){
      return y_sink;
    }
    
    int getIDSource(){
     return id_source; 
    }
    
    int getIDSink(){
      return id_sink;
    }
    
    void drawCut()
    {
        //scale(1,-1);
        //translate(0,-height);
        strokeWeight(3);
        /*
        * Need to subtract 700 that line is drawn properly pretending that (0,0) is on bottom left corner of 
        * of white rectangle
        */
        //System.out.println("x1 " + xCoord1 + " y1 " + yCoord1 + " x2 " + xCoord2 + " y2 " + yCoord2);
        line(x_val, 400 - y_source, x_val, 400 - y_sink);
        //stroke(red, green, blue);
    }
 
}//END Cut Class