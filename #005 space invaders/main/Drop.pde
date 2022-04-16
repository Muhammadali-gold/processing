class Drop {
  float x;
  float y;
  float r=8;
  boolean toDelete= false;
  
  Drop(float x_,float y_){
    x = x_;
    y = y_;
  }
  
  void show(){
    noStroke();
    fill(24,50,173);
    ellipse(x,y,r*2,r*2);
  }
  
  void evaporate(){
    toDelete=true;
  }
  
  boolean hits(Flower flower){
    float d = dist(x,y,flower.x,flower.y);
    if (d < r+flower.r){
      println(this + " "+ flower.x);
      return true;
    }
    return false;
  }
  
  void move(){
    y--;
  }
}
