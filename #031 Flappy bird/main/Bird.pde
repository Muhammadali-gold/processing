class Bird {
  float x = 64;
  float y = height/2;
  
  float r = 32;
  
  float gravity = 0.3;
  float lift = 5;
  float velocity = 0;
  
  
  void show(){
    fill(255);
    //ellipseMode(CORNERS);
    ellipse(x,y,r,r);
  }
  
  void update(){
    velocity+=gravity;
    y+=velocity;
    
    y = constrain(y,r/2,height-r/2);
  }
  
  void up(){
    velocity=-lift;
  }
  
}
