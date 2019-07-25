float mx = 0;
float my = 0;float deg,deg2 = 0;
PImage img,img2;
Enemy e;
PrePlayer p;
Stage3_draw s3;
Title t;

float xP,yP;
float time= 0;
float[] preX = new float[100];
float[] preY = new float[100];
int preN = 0;


class Stage3 extends Stage{
  void events(){}        //about_scroll_change_etc...
 
  void showBg() {
    background(224, 255, 224);

  }
  
  void set_obj(){
  }
  void display() {
    changeWindowSize(600, 700);
    fill(119,188,240);
    ellipse(0,0,1600,1600);
    fill(200);
    ellipse(0,-0,1000,1000);
   //drawGear(); 
  }
}  
class PrePlayer{
  float degP = 0;
  void drawMe(){
    pushMatrix();
    fill(255);
    ellipse(xP,yP,10,10);
    popMatrix();
  }
  
  void move(){
    if(right)xP+=3;
    if(left)xP-=3;
    if(up)yP-=3;
    if(down)yP+=3;
  }
  void preMe(){
    fill(128);
    for(int i = 0;i <100;i++){
      fill(128);
      ellipse(preX[i],preY[i],10,10);
      hit(preMHit(xP,yP));
    }
  }
  
  
   boolean preMHit(float x,float y){
    int flag = 0;
    for(int j = 0;j <100;j++){
      if(dist(x,y,preX[j],preY[j]) <= 10){
       if(preX[j]!=10 && preY[j] != 600){ 
          preX[preN%100] = x;
          preY[preN%100] = y;
          flag = 1;
       }
      }
    }
    if(flag == 1){
      reset();
      return false;
    }
    return true;
  } 
}
class Enemy{
  float [][] enemys = new float[100][2];
  float [] sizeE = new float[100];
  float [] R = new float[100];
  boolean[] h = new boolean[100];
  float xE;
  float yE;
  float[] angle = new float[100];
  void setE(int n){
    for(int i = 0;i < n;i++){
      if(i < n/2){
      xE = (random(-600,-300));
      yE = (random(-600,-300));
      }else{
        xE = (random(300,600));
        yE = (random(300,600));
      }
      sizeE[i] = (random(10,50));
      enemys[i][0] = xE;
      enemys[i][1] = yE;
      R[i] = dist(0,0,xE,yE);
      angle[i] = random(100);
      //ellipse(enemys[i][0],enemys[i][1],sizeE[i],sizeE[i]);
    }
  }
  void drawE(int n){
    for(int i = 0;i < n;i++){
      fill(255,0,0);
      if(!h[i]){
        ellipse((R[i]*cos(angle[i])),(R[i]*sin(angle[i])),sizeE[i],sizeE[i]);
        angle[i]+=0.005;
        enemys[i][0] = R[i]*cos(angle[i]);
        enemys[i][1] = R[i]*sin(angle[i]);
      }
    }
    //println(enemys[0][0],enemys[0][1]);
  }

  boolean enemyHit(float x,float y){
    int flag = 0;
    for(int j = 0;j <100;j++){
      if(dist(x,y,enemys[j][0],enemys[j][1]) <= sizeE[j]/2 && !h[j]){
          preX[preN%100] = x;
          preY[preN%100] = y;
          flag = 1;
      }
    }
    if(flag == 1){
      reset();
      preN++;
      return false;
    }
    return true;
  }
  void preEHit(){
    for(int i = 0;i < 100;i++){
      for(int j = 0;j < 100;j++){
        if(dist(preX[j],preY[j],enemys[i][0],enemys[i][1]) < sizeE[i]/2){
          h[i] = true;
        }
      }
    }
  }
}


void reset(){
  mx = 0;my= 0;
  time = 0;
  xP = 10;
  yP = 600;
}


void hit(boolean x){
  if(!x){
    noLoop();
  }
  if(key == 'r')reset();loop();
}
class Stage3_draw{
  void drawStage(float mx,float my){
    translate(mx,my);
    fill(119,188,240);
    ellipse(0,0,1600,1600);
    fill(200);
    ellipse(0,-0,1000,1000);
    //drawGear(); 
  }
}



  void changeWindowSize(int w, int h) {
  frame.setSize( w + frame.getInsets().left + frame.getInsets().right, h + frame.getInsets().top + frame.getInsets().bottom );
  size(w, h);
  }
  boolean stageHit(float x,float y){
  if(dist(x,y,0,0) > 500 && dist(x,y,0,0) < 800 && xP+mx < width && xP+mx > 0 && yP+my < height && yP+my > 0){
    return true;
  }
  preX[preN%100] = x;
  preY[preN%100] = y;
  return false;
  }
