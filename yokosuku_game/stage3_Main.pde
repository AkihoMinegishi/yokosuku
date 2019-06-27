float deg,deg2 = 0;
PImage img,img2;
Enemy e;
PrePlayer p;
Stage3 s3;
int mx = 0,my = -0;
void setup(){
  size(600,700);
  p = new PrePlayer();
  e = new Enemy();
  s3 = new Stage3();
  e.setE(100);
  img = loadImage("2970.png");
  img2 = loadImage("2970.png");
  img.resize(img.width/5,img.height/5);
  img2.resize(img2.width/3,img2.height/3);
    
}
float time = 0;
void draw(){
  background(200);fill(255,0,0);
  time = millis();
  textSize(50);
  text(time/1000,width-300,height);
  
  if(time > 10000 && my < height/2){
    mx--;
    my+=2;
  }
  translate(mx,my);
  fill(200);
  s3.drawStage(mx,my);

  p.drawMe();
  p.move();
  
}


void drawGear(int mx,int my){
  rectMode(CENTER);
  pushMatrix();
  //translate(0,my);
  rotate(deg*PI/180);
  image(img2,(-img2.width/2),(-img2.height/2));
  e.drawE(100);
  rotate(deg2*PI/180);
  image(img,(-img.width/2),(-img.height/2));
  deg += 0.5;
  deg2 -= 1;
  popMatrix();
}
