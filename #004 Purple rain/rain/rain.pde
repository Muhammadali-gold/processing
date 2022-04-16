// Purple Rain
// 138,43,226
// 230,230,250


Drop[] drops = new Drop[2000];

void setup(){
  size(1980,1000);
  for (int i=0;i<drops.length;i++){
    drops[i] = new Drop();
  }

}

void draw(){
  background(230,230,250);
    for (int i=0;i<drops.length;i++){
    drops[i].fall();
    drops[i].show();
  }
}
