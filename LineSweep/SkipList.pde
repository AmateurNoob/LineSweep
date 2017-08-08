/*
* Authors: Chris Mason, Michael Beiley
* Node class for skiplist
*/

public class SkipList{

  SLNode head = null;
  int maxLevel;
  
  public SkipList(){
    
    // Dummy poiter node, points down to the first node in the list at the max level
    SLNode maxNode = new SLNode(1, MAX_FLOAT, null, null);
    SLNode minNode = new SLNode(1, MIN_FLOAT, maxNode, null);
    
    head = new SLNode(0, 0, null, minNode);
    maxLevel = 1;
  }
  
  void add(Cut new_Cut){
    
    return;
  }
  
  // Private inner node class
private class SLNode{
  private int level;
  private float val;
  
  private SLNode next;
  private SLNode down;
  
  public SLNode(int lvl, float num, SLNode nextNode, SLNode downNode){
    level = lvl;
    val = num;
    next = nextNode;
    down = downNode;
  }
  
  public void setNext(SLNode nextNode){
    next = nextNode;
  }
  
  public void setDown(SLNode downNode){
    down = downNode;
  }
  
  public int getLevel(){
   return level;
  }
  
  public float getVal(){
   return val; 
  }
  
  public SLNode getNext(){
   return next; 
  }
  
  public SLNode getDown(){
   return down; 
  }
  
}

}