//var Status = {
//  NOT_STARTED:-1,
//  IN_PROGRESS:0,
//  WIN:1, 
//  GAME_OVER:2
//}
//Object.freeze(Status);



//var data = {
//  cols:0,
//  rows:0,
//  w:40,
//  grid:[],
//  bombCount:10, 
//  gameStatus:Status.NOT_STARTED,
//  lableBombCount:undefined
//}


 int cols,rows; 

 int w=40;

 Cell[] grid;

 int bombCount=10;


 Status gameStatus=Status.NOT_STARTED; // 0 in-progress 1-win 2-game over

// var setBombCount;

// var lableBombCount;

void setup() {
  //createCanvas(402, 402);
  fullScreen();
  cols = floor(width/w); 
  rows = floor(height/w);

  for (int j =  0; j < rows; j++) {
    for (int i = 0; i < cols; i++) {
      Cell cell = new Cell(i,j); 
      grid[index(i,j)]=cell;
    }
  }
  // frameRate(1);
  // grid[0].hasBomb=true;
  // grid[1].hint=7;

  setBombs(bombCount);  
  calculateHints();

  // user can change bomb count by slider 
  //setBombCount = createSlider(1, 20, 10);
  //setBombCount.position(420, 40);
  //setBombCount.style('width', '60px');
  //lableBombCount = createP('Bomba soni: '+bombCount);
  //lableBombCount.style('font-size', '12px');
  //lableBombCount.position(420, 10);
  // console.log('lableBombCount',lableBombCount)
}

void draw() {
  background(100);

  // update label bomb count and reset board and recalculate hints
  //if (setBombCount.value() != bombCount && gameStatus == Status.NOT_STARTED){
  //    bombCount = setBombCount.value();
  //    setBombs(bombCount);
  //    calculateHints();

  //    lableBombCount.html("Bomba soni: "+bombCount);  
  //}

 //  textSize(40);
 //  fill(0);
  // text('Bomba soni: '+bombCount, 450, 100); 

  int closeCount=0;
  for (Cell cell : grid){
    cell.show();
    if (cell.status == 0){
      closeCount++;
    }
  }
  if (closeCount == bombCount){
    gameStatus = Status.WIN;
    //println("You win");
  } else {
    //println("closeCount",closeCount);
  }

}

void mouseClicked(MouseEvent event) {
  // console.log(event);

  // find which cell clicked
  int col = floor((mouseX-2)/w);
  int row = floor((mouseY-2)/w);
  Cell cell = index(col,row) == -1 ? null :  grid[index(col,row)];
  if (cell != null && gameStatus === Status.NOT_STARTED){
    gameStatus = Status.IN_PROGRESS;
  }
  if (cell != null && gameStatus === Status.IN_PROGRESS){
    //if (event.ctrlKey){
      if (false)
      // set flag or unset flag bomb found
      cell.bombFound=!cell.bombFound;
    } else {
      // open cell
      cell.status=1;
      if (cell.hasBomb){
        print("GAME OVER")
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

void openNeighbors(Cell current_cell){
  for (int i=-1;i<2;i++){
    for (int j=-1;j<2;j++){
      if (i==0 && j==0){
        continue;
      }
      Cell cell = index(current_cell.i+i,current_cell.j+j) == -1 ? null :  grid[index(current_cell.i+i,current_cell.j+j)];
      if (cell != null && !cell.hasBomb && cell.status==0){
        cell.status=1;
        if (cell.hasntNearBomb()){
          openNeighbors(cell);
        }
      }
    }
  }  
}

void showFullBoard(){
  for (Cell cell : grid){
    cell.status=1;
  }
}


void clearCells(){
  for (Cell cell : grid){
    cell.hasBomb=false;
    cell.hint=0;
  }
}

void setBombs(int num){
  clearCells();
  int[] numbers = getRandomNumbers(num);

  for (int n : numbers){
    grid[n].hasBomb=true;
  }

}

int[] getRandomNumbers(int num){
  int[] numbers =new int[grid.length];
  for (int i=0;i<grid.length;i++){
    numbers[i]=i;
  }
  numbers=shuffle(numbers);
  return spliceArr(numbers,0,num);
}

int[] spliceArr(int[] arr,int start,int num){
  int[] arr2 = new int[num];
  
  for (int i=0;i<num;i++){
    arr2[i]=arr[start+i];
  }
  
  return arr2;
}

void calculateHints(){
  for (Cell cell : grid){
    cell.hint = calcHintOfCell(cell);
  }
}


int calcHintOfCell(Cell cell){
  int ci=cell.i;
  int cj=cell.j;
  int hint = 0;
  // let top = grid[index(i,j-1)];
  // let top_right = grid[index(i+1,j-1)];
  // let right = grid[index(i+1,j)];
  // let bottom_right = grid[index(i+1,j+1)];
  // let bottom = grid[index(i,j+1)];
  // let bottom_left = grid[index(i-1,j+1)];
  // let left = grid[index(i-1,j)];
  // let top_left = grid[index(i-1,j-1)];
  for (int i=-1;i<2;i++){
    for (int j=-1;j<2;j++){
      if (i==0 && j==0){
        continue;
      }
      Cell cellx = index(ci+i,cj+j) == -1 ? null : grid[index(ci+i,cj+j)];
      if (cellx != null && cellx.hasBomb){
        hint++;
      }
    }
  }
  return hint;
}

 int[] shuffle(int[] array) {
   int currentIndex = array.length,  randomIndex;

   // While there remain elements to shuffle...
   while (currentIndex != 0) {

     // Pick a remaining element...
     randomIndex = random(currentIndex);
     currentIndex--;

     // And swap it with the current element.
     //[array[currentIndex], array[randomIndex]] = [
     //  array[randomIndex], array[currentIndex]];
     swap(array,currentIndex,randomIndex);
   }

   return array;
 }

void swap(int[] arr,int i,int j){
  int c=arr[i];
  arr[i]=arr[j];
  arr[j]=c;
}

int index(int i, int j){
  if (i<0 || j<0 || i>cols-1 || j>rows-1){
    return -1;
  }
  return i + j * cols;
}
