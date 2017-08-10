******** README ********

LineSweep Algorithm - Implementation 2

The algorithm that we used is as outlined to (Brian) in office hours.

Controls - 
Spacebar advances the sweeping line, and displays output as it was generated
by our algorithm. One tap of the spacebar is equal to one step further in our 
algorithm. 

Output File - 
*****NOTE******
As currently packaged our code will NOT currently generate an output file!

As taken from comments - 

	// Output file is currently sent to Desktop via absolute path
    // Use Users/Chris/Documents/Processing/CSc345_A1/data/ if you want the output file sent to the data file
    // (With Replacement of User name, along with any other changes in file path on your machine)

In order to see the output file - "Chris" should be replaced with your username on your machine. 

This same outfile generation was present in my code for the generation of the lowerEnvelope, but I don't believe that this necessary change was noted at the time of grading.

GUI Issues - Given issues with processing, some of our lines are not being fully extended, as their x/y values are sometimes swapped. This stems from processings X/Y plane being flipped when drawing lines or any other images. This was an issue at multiple points during out generation of cuts, and extending the cut to either the top or lower bound of our window. However, the algorithm is sound, and cuts are always generated with the proper size in the proper location. Our GUI is simply flawed. 

