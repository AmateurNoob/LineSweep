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

void draw() {
  
}