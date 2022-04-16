int calcHintOfCell(Cell cell){
  int ci=cell.i;
  int cj=cell.j;
  int hint = 0;
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
     randomIndex = (int)floor(random(currentIndex));
     currentIndex--;

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


void calculateHints(){
  for (Cell cell : grid){
    cell.hint = calcHintOfCell(cell);
  }
}


int[] spliceArr(int[] arr,int start,int num){
  int[] arr2 = new int[num];
  
  for (int i=0;i<num;i++){
    arr2[i]=arr[start+i];
  }
  
  return arr2;
}

int[] getRandomNumbers(int num){
  int[] numbers =new int[grid.length];
  for (int i=0;i<grid.length;i++){
    numbers[i]=i;
  }
  numbers=shuffle(numbers);
  return spliceArr(numbers,0,num);
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
