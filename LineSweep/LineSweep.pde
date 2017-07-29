/*
 *  Author: Chris Mason
 *  Sidekick: Michael Beiley
 *
 *  CSc 345, Professor Alon Efrat
 */
 
import controlP5.*;

  // Legacy imports
//import java.util.LinkedList;
//import java.io.PrintStream;

ControlP5 cp5;
String filename;

Segment[] segs;

boolean drawSegsFlag = false;

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
            // ****** IF SOMETHINGS FUCKED: CHECK HERE *******
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
       
          //Writing output file
       //try{
         
       //  // Output file is currently sent to Desktop via absolute path
       //  // Use Users/Chris/Documents/Processing/CSc345_A1/data/ if you want the output file sent to the data file
       //  // (With Replacement of User name, along with any other changes in file path on your machine)
       //   PrintWriter writer = new PrintWriter("/Users/Chris/Desktop/" + filename.substring(0,filename.length()-3) + ".out", "UTF-8");
       //   writer.println(lowerEnv.size());
          
       //   for(int i = 0; i < lowerEnv.size(); i++){
       //     System.out.println(i);
       //     writer.println("" + lowerEnv.get(i).getX1() + " " + lowerEnv.get(i).getX2() + " " + lowerEnv.get(i).getY()
       //     + " " + lowerEnv.get(i).getR() + " " + lowerEnv.get(i).getG() + " " + lowerEnv.get(i).getB());
       //   }
       
       //   writer.close();
       // } catch (IOException e) {
       //   e.printStackTrace();
       // }
    }
     
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
    
    } 
}