int cols,rows; 

int w=40;

Cell[] grid;

int bombCount=10;

Status gameStatus=Status.NOT_STARTED; // 0 in-progress 1-win 2-game over
 
int currentCellInd;

int flickTime = 300; // 500 ms o'chib yonishi uchun
int timer;


void setup() {
  size(402, 402);
  //fullScreen();
  cols = floor(width/w); 
  rows = floor(height/w);
  int n=(int) cols*rows;
  grid = new Cell[n];
  for (int j =  0; j < rows; j++) {
    for (int i = 0; i < cols; i++) {
      Cell cell = new Cell(i,j); 
      grid[index(i,j)]=cell;
    }
  }
  // frameRate(1);
   //grid[0].status=1;
  currentCellInd=0;
  
  timer = millis();
  
  setBombs(bombCount);  
  calculateHints();
  
  
}

void draw() {
  background(100);
  int closeCount=0;
  for (Cell cell : grid){
    cell.show();
    if (cell.status == 0){
      closeCount++;
    }
  }
  if (millis() - timer > flickTime){
    if (currentCellInd>=0 && currentCellInd<grid.length){
      grid[currentCellInd].lightOn = !grid[currentCellInd].lightOn;
    }
    timer = millis();
    //println("flicked");
  }
  
  if (closeCount == bombCount){
    gameStatus = Status.WIN;
    //println("You win");
  } else {
    //println("closeCount",closeCount);
  }

}

void keyReleased(){
  if (key == 'a'){
    currentCellInd = constrain(currentCellInd,0,grid.length-1);
    grid[currentCellInd].lightOn = false;
    currentCellInd = constrain(currentCellInd-1,0,grid.length-1);
  }
  if (key == 'w'){
    currentCellInd = constrain(currentCellInd,0,grid.length-1);
    grid[currentCellInd].lightOn = false;
    currentCellInd=constrain(currentCellInd-cols,0,grid.length-1);
  }
  if (key == 's'){
    currentCellInd = constrain(currentCellInd,0,grid.length-1);
    grid[currentCellInd].lightOn = false;
    currentCellInd=constrain(currentCellInd+cols,0,grid.length-1);
  }
  if (key == 'd'){
    currentCellInd = constrain(currentCellInd,0,grid.length-1);
    grid[currentCellInd].lightOn = false;
    currentCellInd=constrain(currentCellInd+1,0,grid.length-1);;
  }
  if (keyCode == 32 || key == 'f'){ // SPACE 
    //int col = floor((mouseX-2)/w);
    //int row = floor((mouseY-2)/w);
    //Cell cell = index(row,col) == -1 ? null :  grid[index(row,col)];
    Cell cell = grid[currentCellInd];
    if (cell != null && gameStatus == Status.NOT_STARTED){
      gameStatus = Status.IN_PROGRESS;
    }
    println(gameStatus);
    if (cell != null && gameStatus.equals(Status.IN_PROGRESS)){
        println(gameStatus);  
        println(cell.i+" " + cell.j);
        if (key == 'f'){
          // set flag or unset flag bomb found
          println(114);
          cell.bombFound=true;
        } 
        else {
        // open cell
        cell.status=1;
        if (cell.hasBomb){
          print("GAME OVER");
          showFullBoard();
          gameStatus = Status.GAME_OVER;
        }
        else if (cell.hint==0){
          openNeighbors(cell);
        }
      }
    
    } else if (gameStatus != Status.IN_PROGRESS) {
      println("Game ended please restart over");
    }  
  }
  //println(keyCode);
}

//void mouseClicked(MouseEvent event) {
//   println(event);

//  // find which cell clicked
//  int col = floor((mouseX-2)/w);
//  int row = floor((mouseY-2)/w);
//  Cell cell = index(col,row) == -1 ? null :  grid[index(col,row)];
//  if (cell != null && gameStatus == Status.NOT_STARTED){
//    gameStatus = Status.IN_PROGRESS;
//  }
//  println(gameStatus);
//  if (cell != null && gameStatus.equals(Status.IN_PROGRESS)){
//      println(gameStatus);  
//      println(cell.i+" " + cell.j);
//      if (mousePressed && mouseButton == RIGHT){
//        // set flag or unset flag bomb found
//        println(114);
//        cell.bombFound=true;
//      } 
//      if (mousePressed && mouseButton == LEFT) {
//      // open cell
//      cell.status=1;
//      if (cell.hasBomb){
//        print("GAME OVER");
//        showFullBoard();
//        gameStatus = Status.GAME_OVER;
//      }
//      else if (cell.hint==0){
//        openNeighbors(cell);
//      }
//    }
  
//  } else if (gameStatus != Status.IN_PROGRESS) {
//    println("Game ended please restart over");
//  }  
//}
