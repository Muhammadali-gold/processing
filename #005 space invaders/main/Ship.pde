class Ship {
  float x = width/2;
  float y = height-40;
  float xSpeed = 10;
  float ySpeed = 10;
  float xdir=0;
  //void update(){
  
  //}
  
  void setDir(float dir){
    xdir=dir;
  }
  
  void move(){
    x+=xSpeed*xdir;
    //y+=y_*ySpeed;
  }
  
  void show(){
    fill(255);
    rect(x,y,20,40);
  }
}
