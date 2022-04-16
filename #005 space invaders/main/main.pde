Ship ship;
Flower[] flowers = new Flower[6];
ArrayList<Drop> drops = new ArrayList<Drop>();
boolean flower_edge=false;


void setup(){
  size(600,400);
  ship = new Ship();
  for (int i=0;i<flowers.length;i++ ){
    flowers[i] = new Flower(i*80+80,60);  
  }
}

void draw(){
  background(51);
  ship.show();
  ship.move();

  for (int i=0;i<drops.size();i++ ){
    drops.get(i).move();
    drops.get(i).show();
    for (int j=0;j<flowers.length;j++ ){
      if (drops.get(i).hits(flowers[j])){
        flowers[j].grow();
        drops.get(i).evaporate();
      }
    }  
  }

  for (int i=0;i<flowers.length;i++ ){
    flowers[i].show();
    flowers[i].move();
    if (flowers[i].x > width || flowers[i].x < 0){
      flower_edge=true;
    }
  }
  for (int i=0;i<flowers.length;i++ ){
    if (flower_edge){
      flowers[i].shiftDown();  
    }
  }
  flower_edge=false;
  
  for (int i=drops.size()-1;i>-1;i-- ){
    if (drops.get(i).toDelete){
      drops.remove(i);
    }
  }
}

void keyReleased(){
  if (key != ' '){
    ship.setDir(0);
  }
}

void keyPressed(){
  if (keyCode == LEFT){
    ship.setDir(-1);
  }
  if (keyCode == RIGHT){
    ship.setDir(1);
  }
  if (key == ' '){
     drops.add(new Drop(ship.x+10,ship.y)); 
  }
}  
