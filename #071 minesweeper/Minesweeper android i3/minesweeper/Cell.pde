class Cell {
  public int i;
  public int j;
  public boolean hasBomb=false;
  public int hint = 0;
  public int status=0;  // 0 close 1 open
  public boolean bombFound=false;
  
  
  public Cell(int i,int j){
    this.i=i;
    this.j=j;
  }
  //this.i=i;
  //this.j=j;
  // this.walls = [true,true,true,true]; // top,right,bottom,left
  // this.visited=false;
  //this.hasBomb=false;
  //this.hint = 0;
  //this.status=0;  // 0 close 1 open
  //this.bombFound=false;

  public void show (){
    int x = this.i*w+1; // 2 for outer wall
    int y = this.j*w+1; // 2 for outer wall
    stroke(0);
    // if (this.walls[0]){
      line(x,y,x+w,y);      
    // }
    // if (this.walls[1]){
      line(x+w,y,x+w,y+w);
    // }
    // if (this.walls[2]){
      line(x+w,y+w,x,y+w);
    // }
    // if (this.walls[3]){
      line(x,y+w,x,y);
    // }

    if (this.status == 1){
      noStroke();
      fill(253,253,253);
      rect(x,y,w,w);
      if (this.hasBomb){
        fill(127,127,127);
         ellipse(x+w/2,y+w/2,w*0.5,w*0.5);
      }
      else if (this.hint>0){
         textSize(w*0.7);
         fill(50);
         text(this.hint, x+w*0.3, y+w*0.75); 
      } 
    } else if (this.bombFound){
        noStroke();
        fill(253,0,0);  
        rect(x,y,w,w);
    }
  }

  public boolean hasntNearBomb(){
    return this.hint == 0;
  }

  public boolean isClose(){
    return this.status == 0;
  }

}
