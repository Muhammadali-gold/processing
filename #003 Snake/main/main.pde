Snake s;
PVector food;
float scl=10;
void setup(){
  size(600,600);
  s = new Snake();
  frameRate(10);
  pickLocation();
 }

void pickLocation(){
  float cols = floor(width/scl);
  float rows = floor(height/scl);
  food = new PVector(floor(random(cols)),floor(random(rows)));
  food.mult(scl);
}

void draw(){
  background(51);
  s.update();
  s.show();
  s.death();
  if (s.eat(food)){
    pickLocation();
    s.addTail();
  }
  
 
  fill(255,0,100);
  rect(food.x,food.y,scl,scl);
}

void keyPressed() {
  if (keyCode == UP){
    s.dir(0,-1);
  }
  if (keyCode == DOWN){
    s.dir(0,1);
  }
  if (keyCode == RIGHT){
    s.dir(1,0);
  }
  if (keyCode == LEFT){
    s.dir(-1,0);
  }
}
