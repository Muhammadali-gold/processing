var Status = {
	NOT_STARTED:-1,
	IN_PROGRESS:0,
	WIN:1, 
	GAME_OVER:2
}
Object.freeze(Status);



var data = {
	cols:0,
	rows:0,
	w:40,
	grid:[],
	bombCount:10, 
	gameStatus:Status.NOT_STARTED,
	lableBombCount:undefined
}


// var cols,rows; 

// var w=40;

// var grid = [];

// var bombCount=10;


// var gameStatus=Status.NOT_STARTED; // 0 in-progress 1-win 2-game over

// var setBombCount;

// var lableBombCount;

function setup() {
  createCanvas(402, 402);

  data.cols = floor(width/data.w); 
  data.rows = floor(height/data.w);

  for (var j =  0; j < data.rows; j++) {
    for (var i = 0; i < data.cols; i++) {
      var cell = new Cell(i,j); 
      data.grid.push(cell);
    }
  }
  // frameRate(1);
  // grid[0].hasBomb=true;
  // grid[1].hint=7;

	setBombs(data.bombCount);  
	calculateHints();

  // user can change bomb count by slider 
	data.setBombCount = createSlider(1, 20, 10);
  data.setBombCount.position(420, 40);
  data.setBombCount.style('width', '60px');
  data.lableBombCount = createP('Bomba soni: '+data.bombCount);
	data.lableBombCount.style('font-size', '12px');
	data.lableBombCount.position(420, 10);
	// console.log('lableBombCount',lableBombCount)
}

function draw() {
  background(100);

  // update label bomb count and reset board and recalculate hints
  if (data.setBombCount.value() !== data.bombCount && data.gameStatus === Status.NOT_STARTED){
  		data.bombCount = data.setBombCount.value();
  		setBombs(data.bombCount);
			calculateHints();

  		data.lableBombCount.html('Bomba soni: '+data.bombCount);  
  }

 //  textSize(40);
 //  fill(0);
	// text('Bomba soni: '+bombCount, 450, 100); 

  let closeCount=0;
  for (let cell of data.grid){
    cell.show();
    if (cell.status === 0){
    	closeCount++;
    }
  }
  if (closeCount === data.bombCount){
  	data.gameStatus = Status.WIN;
  	console.log('You win');
  } else {
    // console.log('closeCount',closeCount)
  }

}

function mouseClicked(event) {
  // console.log(event);

  // find which cell clicked
	let col = floor((mouseX-2)/data.w);
	let row = floor((mouseY-2)/data.w);
	let cell = data.grid[index(col,row)];
	if (cell && data.gameStatus === Status.NOT_STARTED){
		data.gameStatus = Status.IN_PROGRESS;
	}
	if (cell && data.gameStatus === Status.IN_PROGRESS){
	  if (event.ctrlKey){
	  	// set flag or unset flag bomb found
	  	cell.bombFound=!cell.bombFound;
	  } else {
		  // open cell
			cell.status=1;
			if (cell.hasBomb){
				console.log('GAME OVER')
				showFullBoard();
				data.gameStatus = Status.GAME_OVER;
			}
			else if (cell.hint===0){
				openNeighbors(cell);
			}
	  }
	} else if (data.gameStatus !== Status.IN_PROGRESS) {
		console.log('Game ended please restart over');
	}	
}

function openNeighbors(current_cell){
	for (let i=-1;i<2;i++){
		for (let j=-1;j<2;j++){
			if (i===0 && j===0){
				continue;
			}
			let cell = data.grid[index(current_cell.i+i,current_cell.j+j)]
			if (cell && !cell.hasBomb && cell.status===0){
				cell.status=1;
				if (cell.hasntNearBomb()){
					openNeighbors(cell);
				}
			}
		}
	}	
}

function showFullBoard(){
	for (let cell of data.grid){
		cell.status=1;
	}
}


function clearCells(){
	for (let cell of data.grid){
		cell.hasBomb=false;
		cell.hint=0;
	}
}

function setBombs(num){
	clearCells();
	let numbers = getRandomNumbers(num);

	for (let n of numbers){
		data.grid[n].hasBomb=true;
	}

}

function getRandomNumbers(num){
	let numbers = []
	for (let i=0;i<data.grid.length;i++){
		numbers[i]=i;
	}
	numbers=shuffle(numbers);
	return numbers.splice(0,num);
}


function calculateHints(){
	for (let cell of data.grid){
		cell.hint = calcHintOfCell(cell);
	}
}


function calcHintOfCell(cell){
	let ci=cell.i;
	let cj=cell.j;
	let hint = 0;
	// let top = grid[index(i,j-1)];
	// let top_right = grid[index(i+1,j-1)];
	// let right = grid[index(i+1,j)];
	// let bottom_right = grid[index(i+1,j+1)];
	// let bottom = grid[index(i,j+1)];
	// let bottom_left = grid[index(i-1,j+1)];
	// let left = grid[index(i-1,j)];
	// let top_left = grid[index(i-1,j-1)];
	for (let i=-1;i<2;i++){
		for (let j=-1;j<2;j++){
			if (i===0 && j===0){
				continue;
			}
			let cell = data.grid[index(ci+i,cj+j)]
			if (cell && cell.hasBomb){
				hint++;
			}
		}
	}
	return hint;
}

// function shuffle(array) {
//   let currentIndex = array.length,  randomIndex;

//   // While there remain elements to shuffle...
//   while (currentIndex != 0) {

//     // Pick a remaining element...
//     randomIndex = Math.floor(Math.random() * currentIndex);
//     currentIndex--;

//     // And swap it with the current element.
//     [array[currentIndex], array[randomIndex]] = [
//       array[randomIndex], array[currentIndex]];
//   }

//   return array;
// }

function index(i,j){
  if (i<0 || j<0 || i>data.cols-1 || j>data.rows-1){
    return -1;
  }
  return i + j * data.cols;
}


