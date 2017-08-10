/*
 *  Authors: Chris Mason, Michael Beiley
 *
 *  CSc 345, Professor Alon Efrat
 */
 
import controlP5.*;
import java.util.Arrays;

  // Legacy imports
import java.util.LinkedList;
//import java.io.PrintStream;

ControlP5 cp5;
String filename;
SkipList SL = new SkipList();

Segment[] segs;
Segment[] segsX2;

int cutCounter = -1;
LinkedList<Cut> cuts = new LinkedList<Cut>();

boolean drawSegsFlag = false;
boolean drawFlag = false;

void setup() {
  // Window is the size of our input range
  size(800, 400);

  // Set font for title screen
  textFont(createFont("arial", 50));
  text("LineSweeper", 250, 100, width, height);
  
  // Set default font
  textFont(createFont("arial", 20));

  // Input text field comes from the processing cp5 library 
  // Adapted from Brians sample code for the GUI
  cp5 = new ControlP5(this);
  cp5.addTextfield("Enter File Name")
    .setPosition(width/2 - 150, height/2 - 20)
    .setSize(300, 40)
    .setFont(createFont("arial", 20))
    .setFocus(true)
    .setColor(255);
}

// Based heavily on Brians sample code
// Credit for base code goes to Brian Carlos Carbajal
void loadData() {
  BufferedReader read;
 
    String str = null;
    float x1, y1, x2, y2;
    int i = 0;
    try{
        // Uses buffered reader to read from input file 
        read = createReader(filename);
        while((str = read.readLine()) != null)
        {
            if(str.length() <= 3) //Check to see if we are reading the first line, kinda hacky, only works for up to 999 segments
            {
                segs = new Segment[Integer.parseInt(str)];
            }
            else{ // Readline to get values for the segment to be created
                String[] arr = str.split("\\s+"); //Split string on any whitespace, original code only split on spaces
                // Splitting only on spaces causes issues with parsing
               
                // Get position values
                x1 = Float.parseFloat(arr[0]);
                y1 = Float.parseFloat(arr[1]);
                x2 = Float.parseFloat(arr[2]);
                y2 = Float.parseFloat(arr[3]);
                
                //create new segment
                Segment seg = new Segment(x1, y1, x2, y2);
                
                segs[i] = seg;
                i++;
            }          
        }
    }catch(IOException e)
    {
        e.printStackTrace();
    }
    
    drawSegsFlag = true;
}

// Used for both entering a file, and as the cue to display the next recursive step
void keyPressed() {
  // Enter is used to parse a file
  // Makes sure to check that theres currently no file given
    if(key == ENTER && filename == null) {
        //Get string from text field
        filename = cp5.get(Textfield.class, "Enter File Name").getText(); 
        
        // CHeck to make sure string is not empty/null
        if(filename != null && !filename.isEmpty())
        {
            cp5.get(Textfield.class, "Enter File Name").clear(); // Clear text in text field
            
            if(filename.length() < 3){
              filename = filename + "" + ".in";
            }
            else if(!filename.substring(filename.length() - 3).equals(".in")){
              filename = filename + "" + ".in";
            }
        }
        
        // Load data if filename is given
      if(filename != null)
        loadData();    
       
       // Array of segments are sorted by x1-val
       segsX2 = Arrays.copyOf(segs, segs.length);
       
       // swap x values
       
       for(Segment seg : segsX2){
         seg.setX(seg.getX2(), seg.getX1());
         seg.setY(seg.getY2(), seg.getY1());
       }
       
       Arrays.sort(segs);
       Arrays.sort(segsX2);
       buildList();
       
          //Writing output file
       try{
         
         // Output file is currently sent to Desktop via absolute path
         // Use Users/Chris/Documents/Processing/CSc345_A1/data/ if you want the output file sent to the data file
         // (With Replacement of User name, along with any other changes in file path on your machine)
          PrintWriter writer = new PrintWriter("/Users/Chris/Desktop/" + filename.substring(0,filename.length()-3) + ".out", "UTF-8");
          writer.println(cuts.size());
          
          for(int i = 0; i < cuts.size(); i++){
            writer.println("" + cuts.get(i).getX() + " " + cuts.get(i).getY1() + " " + cuts.get(i).getY2()
            + " " + cuts.get(i).getIDSource() + " " + cuts.get(i).getIDSink());
          }
       
          writer.close();
        } catch (IOException e) {
          e.printStackTrace();
        }
    }
    
    if(key == ' ' && filename != null) {
      if(cutCounter < cuts.size()-1)
        cutCounter++;
    }
     
}

void buildList(){
  for(float i = 0; i <= 800; i ++){
    Segment ref = null;
    ref = binarySearchX1(i);
    
    if(ref == null)
      ref = binarySearchX2(i);
    
    if(ref != null){
      //float pVal = findPredecessor(ref, i);
      //float sVal = findSuccessor(ref, i);
      
      float pVal = MIN_FLOAT;
      float sVal = MAX_FLOAT;
      
      int pID = 0;
      int sID = 0;
      int counter = 0;
      
      
      float yVal = findY(ref, i);
      
      for(Segment seg : segs){
        // Still have to check if x values of the segment bound your ref segment
        
        float tempY = findY(seg, i);
        //System.out.println("Y val: " + tempY);
        
         if(tempY < sVal && tempY > yVal){
           sVal = tempY;
           sID = counter;
         }
         if(tempY > pVal && tempY < yVal){
           pVal = tempY;
           pID = counter;
         }
        
        counter++;
      }
      
      if(pVal == MIN_FLOAT)
        pVal = 0;
      if(sVal == MAX_FLOAT)
        sVal = 800;
      
      Cut pCut = new Cut(i, pVal, yVal, pID, sID);
      Cut sCut = new Cut(i, yVal, sVal, sID, pID);
      
      //System.out.println(pCut.getY1() + " " + pCut.getY2());
      //System.out.println(sCut.getY1() + " " + sCut.getY2());
      
      SL.head = SL.add(pCut, SL.head, level(), SL.height);
      SL.head = SL.add(sCut, SL.head, level(), SL.height);
      
      SL.head.printList();
      
      cuts.add(pCut);
      cuts.add(sCut);
    }
  }
}

int level(){
 
   int k = 0;
   while((int)random(1) == 1){
       k++; 
    }
    
    return k;
}
float findY(Segment ref, float cutX){
  float slope = (ref.getY1() - ref.getY2()) / (ref.getX1() - ref.getX2());
  
  return (slope * (cutX - ref.getX1())) + ref.getY1();
}

Segment binarySearchX1(float sVal){
  int j = 0;
  int k = segs.length-1;
  
  while(k >= j){
    
    int mid = (j + k)/2;
    if(segs[mid].getX1() == sVal)
      return segs[mid];
    else if(segs[mid].getX1() < sVal)
      j = mid + 1;
    else if(segs[mid].getX1() > sVal)
      k = mid - 1;
  }
  
  return null;
}

Segment binarySearchX2(float sVal){
  int j = 0;
  int k = segsX2.length-1;
  
  while(k >= j){
    int mid = (j + k)/2;
    if(segsX2[mid].getX2() == sVal)
      return segsX2[mid];
    else if(segsX2[mid].getX2() < sVal)
      j = mid + 1;
    else if(segsX2[mid].getX2() > sVal)
      k = mid - 1;
  }
  
  return null;
}


void draw() {
  if(filename != null){
    clear();
    cp5.remove("Enter File Name");
    background(220);
  }
    
    // Check to see if segments need to be drawn.
    // Flag will be turned on once a file has been read
    if(drawSegsFlag){
        // Draw segments in array
        for(Segment seg: segs){
            seg.drawSeg();
        }
        
        //print(cuts.size());
        
        for(int i = 0; i <= cutCounter; i++){
          System.out.println(cuts.get(i).getIDSource() + " " + cuts.get(i).getIDSink());
          cuts.get(i).drawCut();
        }
    } 
    
    if(filename != null){
      fill(0, 0, 255, 127);
      
      if(drawFlag){
        rect(segs[cutCounter/2-segs.length].getX1()-5, 0, 10, 400);
      }
      else{
        if(cutCounter/2 == segs.length){
          drawFlag = true;
        }
        else
          rect(segs[cutCounter/2].getX2()-5, 0, 10, 400); 
        
      }
      
    }
    
    
}