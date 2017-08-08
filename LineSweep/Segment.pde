/*
* Author: Brian Carlos Carbajal?*
*
* Adapted by: Chris Mason
*
* Provided Segment class, with added get() methods for RGB values
*/

class Segment implements Comparable<Segment>{
    //private Segment next;
    //private Segment prev;
    private float xCoord1;
    private float xCoord2;
    private float yCoord1;
    private float yCoord2;  
    
    public Segment(float x1, float y1, float x2, float y2)
    {
        xCoord1 = x1;
        xCoord2 = x2;
        yCoord1 = y1; 
        yCoord2 = y2;
        
    }//END Constructor
    
    /************* Getters and Setters for Segment Object *********/
    public void setX(float x1, float x2){
        xCoord1 = x1;
        xCoord2 = x2;
    }
    
    public void setY(float y1, float y2){
        yCoord1 = y1;
        yCoord2 = y2;
    }
    
    public float getX1(){
        return xCoord1;
    }
    
    public float getX2()
    {
        return xCoord2;
    }
    
    public float getY1()
    {
        return yCoord1;
    }
    
    public float getY2()
    {
        return yCoord2;
    }
    
    /*********** End Getters and Setters ********/
    
    /*
    * Implement draw for drawing segment
    */
    
    void drawSeg()
    {
        //scale(1,-1);
        //translate(0,-height);
        strokeWeight(3);
        /*
        * Need to subtract 700 that line is drawn properly pretending that (0,0) is on bottom left corner of 
        * of white rectangle
        */
        //System.out.println("x1 " + xCoord1 + " y1 " + yCoord1 + " x2 " + xCoord2 + " y2 " + yCoord2);
        line(xCoord1, 400 - yCoord1, xCoord2, 400 - yCoord2);
        //stroke(red, green, blue);
    }//END drawSwg
    
    @Override
    int compareTo(Segment seg){
      if(this.getX1() == seg.getX1())
        return 0;
      else if(this.getX1() > seg.getX1())
        return 1;
      else
        return -1;
    }
    
    
}//END Segment Class