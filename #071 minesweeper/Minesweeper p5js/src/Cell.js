function Cell(i,j){
  this.i=i;
  this.j=j;
  // this.walls = [true,true,true,true]; // top,right,bottom,left
  // this.visited=false;
  this.hasBomb=false;
  this.hint = 0;
  this.status=0;  // 0 close 1 open
  this.bombFound=false;

  this.show = ()=>{
    var x = this.i*data.w+1; // 2 for outer wall
    var y = this.j*data.w+1; // 2 for outer wall
    stroke(0);
    // if (this.walls[0]){
      line(x,y,x+data.w,y);      
    // }
    // if (this.walls[1]){
      line(x+data.w,y,x+data.w,y+data.w);
    // }
    // if (this.walls[2]){
      line(x+data.w,y+data.w,x,y+data.w);
    // }
    // if (this.walls[3]){
      line(x,y+data.w,x,y);
    // }

    if (this.status === 1){
      noStroke();
	  fill(253,253,253);
      rect(x,y,data.w,data.w);
      if (this.hasBomb){
        fill(127,127,127);
       	ellipse(x+data.w/2,y+data.w/2,data.w*0.5,data.w*0.5);
      }
      else if (this.hint>0){
       	textSize(data.w*0.7);
       	fill(50);
		text(this.hint+'', x+data.w*0.3, y+data.w*0.75); 
      } 
    } else if (this.bombFound){
        noStroke();
        fill(253,0,0);	
        rect(x,y,data.w,data.w);
    }
  }

  this.hasntNearBomb = ()=>{
  	return this.hint === 0;
  }

  this.isClose = ()=>{
  	return this.status === 0;
  }

}