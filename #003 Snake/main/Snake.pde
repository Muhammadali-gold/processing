class Snake {
  int x=0;
  int y=0;
  int xSpeed=1;
  int ySpeed=0;
  int total=0;
  ArrayList<PVector> tail = new ArrayList<PVector>();
 
  void dir(int xSpeed_,int ySpeed_){
    xSpeed = xSpeed_;
    ySpeed = ySpeed_;
  }
  
  void death(){
    for (int i=0;i<total;i++){
       PVector pos =  tail.get(i);
       if (dist(x,y,pos.x,pos.y) < 1){
         println("start over");
         total=0;
         tail.clear();
       }
    }
  }
  
  void show(){
     fill(255); 
    for (int i=0;i<total;i++){
        rect(tail.get(i).x,tail.get(i).y,scl,scl);
    }
    fill(255);
    rect(x,y,scl,scl);
  }
  
  boolean eat(PVector food){
    float d = dist(x,y,food.x,food.y);
    return d<1;
  }
  
  void addTail(){
    tail.add(new PVector(x,y));
    total++;
  }
  
  void update(){
    ArrayList<PVector> tailsss = new ArrayList<PVector>();

    if (total == tail.size() && total>0){
      for (int i=0;i<total-1;i++){
        tailsss.add(i,tail.get(i+1));
      }
      tailsss.add(new PVector(x,y));
      tail.clear();
      tail.addAll(tailsss);
    }
    //println(tail);
    
    
    x+=xSpeed*scl;
    y+=ySpeed*scl;
    x = constrain(x,0,width-(int)scl);
    y = constrain(y,0,height-(int)scl);
  }
}
