class Pipe {
  float top = random(height/2);
  float bottom = random(height/2);
  
  float x = width;
  float w = 20;
  
  float speed=2;
  
  boolean highlight = false;
  
  void show(){
    fill(255);
    if (highlight){
      fill(255,0,0);
    }
    rect(x,0,w,top);
    rect(x,height-bottom,w,bottom);
  }
  
  void update(){
    x-= speed;
  }
  
  boolean offscreen(){
    return x < -w;
  }
  
  boolean hits(Bird bird){
    if (bird.y < top || bird.y > height-bottom){
      if (bird.x - x < w && bird.x > x){
        highlight = true;
        return true;
      }
    }
    highlight = false;
    return false;
  }
  
}
