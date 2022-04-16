Bird bird;
//Pipe[] pipes = new Pipe[100];
ArrayList<Pipe> pipes = new ArrayList<Pipe>();
//int pipeLength=0;
void setup(){
  size(400,600);
  pipes.add(new Pipe());
  //pipeLength=1;
  bird = new Bird();
}


void draw(){
  background(0);
  
  bird.update();
  bird.show(); 
  
  if (frameCount % 100 == 0){
    pipes.add(new Pipe());
  }
  
  
  //if (frameCount>200*5 && frameCount % 200 == 0){
  //  pipes.remove(0);
  //  pipeLength++;
  //}
  
  for (int i=pipes.size()-1;i>=0;i--){
    if (pipes.get(i).offscreen()){
      pipes.remove(i);
    }
    if (pipes.get(i).hits(bird)){
      println(i+"->hit");
    }
    pipes.get(i).update();
    pipes.get(i).show();
  }
}

void keyPressed(){
  if (key == ' '){
    //println("Space");
    bird.up();
  }
}
