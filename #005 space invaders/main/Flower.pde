class Flower {
  float x=0;
  float y=0;
  float r=30;
  
  float xdir = 1;
  
  Flower(float x_,float y_){
    x = x_;
    y = y_;
  }
  
  void shiftDown(){
    xdir*=-1;
    y+=2*r;
  }

  void grow(){
    r+=2;
  }
  
  void show(){
    fill(255,0,200,50);
    //rectMode(CENTER);
    ellipse(x,y,r*2,r*2);
  }
  
  void move(){
    x+=xdir;
    
  }
}
