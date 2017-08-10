/*
* Authors: Chris Mason, Michael Beiley
* Class for skiplist
*/

public class SkipList{

  SLNode head = new SLNode(0, null, null, null);
  SLNode temp = null;
  SLNode nodeAbove = null;
  SLNode maxNode;
  SLNode minNode;
  Cut maxCut = new Cut(MAX_INT, 0, 0, 0, 0);
  Cut minCut = new Cut(MIN_INT, 0, 0, 0, 0);

  int height;
  boolean insDownPtr = false;
  
  public SkipList(){
    
    // Dummy poiter node, points down to the first node in the list at the max level
    maxNode = new SLNode(0, maxCut, null, null);
    minNode = new SLNode(0, minCut, maxNode, null);
    
    head = minNode;
    height = 0;
  }
  
  SLNode add(Cut new_Cut, SLNode root, int level, int height){            
      
    // Avoid nullpointers
    if(root.next == null || root == null){
      
      return head;
    }
    // Inserting into empty list
    if(root.next.aCut.x_val == MAX_INT && height == 0){
      
       temp = root;
       SLNode newNode = new SLNode(0, new_Cut, temp.next, null);
       root.next = newNode;
       
       head = addLevel(head);
       return head;
    }
    
    
    if(root.level == height && root.next.aCut.x_val == MAX_INT){
     
      temp = root;
      SLNode newNode = new SLNode(0, new_Cut, temp.next, null);
      root.next = newNode;
       
      head = addLevel(head);
      
      if(insDownPtr){
       
        nodeAbove.setDown(newNode);
      }
      if(root.level != 0){
        
        nodeAbove = newNode;
        insDownPtr = true;
      }
      return head;
    }
    // Simplification to make implementation easier
    if(level > root.level) 
      level = root.level + 1;
    
    if(root.next == null){
     
       SLNode newNode = new SLNode(level, new_Cut, null, null);
       root.next = newNode;
       
       if(insDownPtr == true){
        
         nodeAbove.setDown(newNode);
       }
       if(level != 0){
        
         nodeAbove = newNode;
         insDownPtr = true;
       }
    }
    if(root.next.aCut.x_val < new_Cut.x_val){
      
      return add(new_Cut, root.next, level, this.height);
    }
         
      // Base Case
      if(root.level == 0){
         
        temp = root.next; // Succ of new Node
        root.next = new SLNode(level, new_Cut, temp, null); 
        if(insDownPtr){
         
          nodeAbove.setDown(root.next);
        }
        insDownPtr = false;
        return head;
      }
      else{
       
        // Might not work as intended - head pointer may be off
        if(level > root.level){
         
          SLNode newNode = new SLNode(root.level, new_Cut, null, head.down); // Replaces head dummy node
          SLNode newHead = new SLNode(level+1, null, null, newNode); // New dummy head node
          head = newHead;
          
          insDownPtr = false;
        }
        else{
                     
            temp = root.next;
            SLNode newNode = new SLNode(level, new_Cut, temp, null);
            if(insDownPtr == true){
             
              nodeAbove.setDown(newNode);
            }
            
            insDownPtr = true;   // Flag signaling to insert a down pointer in next call
            nodeAbove = newNode; // Keep track of new node for down pointer
            root.next = newNode; // Insert newNode
        }
        
        return add(new_Cut, root.down, level-1, this.height);
      }
    
}

SLNode addLevel(SLNode root){
 
   SLNode newTail = new SLNode(root.level+1, maxCut, null, maxNode); // New tail node
   SLNode newHead = new SLNode(root.level+1, minCut, newTail, minNode); // New dummy head node
   maxNode = newTail;
   minNode = newHead;
   head = newHead;
     
   this.height++;
   return head;
}
  
  // Private inner node class
private class SLNode{
  private int level;
 // private float val;
  
  private SLNode next;
  private SLNode down;
  Cut aCut;

  public SLNode(int lvl, Cut thisCut, SLNode nextNode, SLNode downNode){
    level = lvl;
   // val = num;
    aCut = thisCut;
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
  
  public SLNode getNext(){
   return next; 
  }
  
  public SLNode getDown(){
   return down; 
  }
  
  public void printList(){
   
    while(head.down != null){
     
      head = head.down;
    }
    
    while(head.next != null){
     
      println(head.next.aCut.x_val);
      head = head.next;
    }
  }
  
}

}