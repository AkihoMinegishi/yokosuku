class GameFlow {
  int diecnt = 0;
  
  void dead() {
    diecnt++;
  }
  
  int deadCount() {
    return diecnt;
  }
}

int choice = 0;
class Title {
   void display_title() {
    int size = 24;
    String mes = "the game";
    background(0);
    textSize(size);
    text(mes, width/2 - size*mes.length()/3, height/2);
    ellipse(width/4,height*2/3,30,30);
    ellipse(width*2/4,height*2/3,30,30);
    ellipse(width*3/4,height*2/3,30,30);
    if(dist(mouseX,mouseY,width*3/4,height*2/3) < 30){
      if(mousePressed){
        choice = 3;
      }
    }
   }
   

}

class Stage {
  float[] prex = new float[128], 
          prey = new float[128], 
          pred = new float[128];
  int precnt = 0;
  
  void showBroken() {
    for(int i = 0; i < precnt; i++) {
      fill(128, 0, 0);
      ellipse(prex[i], prey[i], pred[i], pred[i]);
    }
  }
  
  void inputPre(float px, float py, float pd) {
    prex[precnt] = px;
    prey[precnt] = py;
    pred[precnt] = pd;
    precnt++;
  }
  
  float[] callBroken(int i) {
    float sets[] = {prex[i], prey[i], pred[i], pred[i]};
    return sets;
  }
}

class Stage1 {
}

class Stage2 {
}

class Stage3 {
}

class Stage4 {
}

class Chara {
  float cx, cy, cd = 30.0, cr = cd / 2.0;
  int lifemax = 3, life = 3, dam = 3;
  color chcol;
  boolean playing = true;
  
  boolean ifsafe_area(float area[]) {
    if(area[0] <= cx + cd / 2 && cx - cd / 2 <= area[1] 
       && area[2] <= cy + cd / 2 && cy - cd / 2 <= area[3]) {
      return false;
    } else {
      return true;
    } 
  }
  
  boolean ifsafe_elps(float sets[]) {
    float ex = sets[0], ey = sets[1], ew = sets[2], eh = sets[3];
    if(pow(cx - ex, 2) * pow(ew / 2.0 + cr, -2) + pow(cy - ey, 2) * pow(eh / 2.0 + cr, -2) <= 1) {
      return false;
    } else {
      return true;
    }
  }
  
  void damage() {
    life -= dam;
    if(life < 0) {
      life = 0;
    }
  }
  
  boolean ifdead() {
    if(life <= 0) {
      return true;
    } else {
      return false;
    }
  }
  
  void move_chara(float stepx, float stepy) {
    if(playing) {
      if((0 <= cx - cd / 2 && stepx < 0) || (cx + cd / 2 <= width && stepx > 0)) {
        cx += stepx;
      }
      if((0 <= cy - cd / 2 && stepy < 0) || (cy + cd / 2 <= height && stepy > 0)) {
        cy += stepy;
      }
      if(cx - cd / 2 < 0) {
        cx = cd / 2;
      } else if(width < cx + cd / 2) {
        cx = width - cd / 2;
      }
      if(cy - cd / 2 < 0) {
        cy = cd / 2;
      } else if(height < cy + cd / 2) {
        cy = height - cd / 2;
      }
    }
  }
  
  void warp_chara(float dx, float dy) {
    if(playing) {
      cx = dx;
      cy = dy;
    }
  }
  
  void draw_chara() {
    fill(chcol);
    ellipse(cx, cy, cd, cd);
  }
  
  void init() {
    cx = width / 2;
    cy = height / 2;
    chcol = color(128, 255, 0);
    life = lifemax;
    playing = true;
  }
  
  void dead() {
    playing = false;
    chcol = color(128, 0, 0);
  }
}

GameFlow gf = new GameFlow();
Stage st = new Stage();
Chara ch = new Chara();


void showMessage(String mes, int strsize, int strX, int strY) {
  fill(0);
  textSize(strsize);
  text(mes, strX, strY);
}

void init_game() {
  ch.init();
}

void askContinue() {
  showMessage("PRESS 'R' TO PLAY AGAIN", 16, width / 2, height / 2 + 24);
  if(keyPressed && (key == 'r' || key == 'R')) {
    gf.dead();
    st.inputPre(ch.cx, ch.cy, ch.cd);
    init_game();
  }
}

void gameFailed() {
  showMessage("You Lose :(", 28, width / 2, height / 2);
  askContinue();
}

void jud_safe() {
  int i;
  float walls[][] = {{width, width + 1.0, 0.0, height},
                       {-1.0, 0.0, 0.0, height},
                       {0.0, width, -1.0, 0.0},
                       {0.0, width, height, height + 1.0}};
  for(i = 0; i < 4; i++) {
    if(ch.ifsafe_area(walls[i]) == false) {
      ch.damage();
      if(ch.ifdead()) {
        break;
      }
    }
  }
  
  for(i = 0; i < gf.deadCount(); i++) {
    if(ch.ifsafe_elps(st.callBroken(i)) == false) {
      ch.damage();
      if(ch.ifdead()) {
        break;
      }
    }
  }
  
  if(ch.ifdead()) {
    ch.dead();
  }
}


////////////////////stage3///////////////////////////
float deg,deg2 = 0;
PImage img,img2;
Enemy e;
PrePlayer p;
Stage3_draw s3;
Title t;

float xP,yP;
float time= 0;
//////////////////////////////////////////////////////



void setup() {
  size(600, 400);
  ///////////////////stage3////////////////////////////
  xP = 10;
  yP = 600;
  time = 0;
  p = new PrePlayer();
  e = new Enemy();
  s3 = new Stage3_draw();
  e.setE(100);
  //img = loadImage("2970.png");
  //img2 = loadImage("2970.png");
  //img.resize(img.width/5,img.height/5);
  //img2.resize(img2.width/3,img2.height/3);
  frameRate(60);
  ///////////////////////////////////////////////////////
  t = new Title();
  init_game();
}
float mx = 0;
float my = 0;
void draw() {
  background(255);
  if(choice == 3){
  //title画面から3を選ぶと////
  changeWindowSize(600, 700);
  println(time);
  time++;
  if(time%4000 > 100 && time%2000 < 450){
    mx-=0.5;my+=1.0;
  }else if(time%2200 > 600 && time%2200 < 1000){
    mx+=1;
  }else if(time%2200 > 1100 && time%2200 < 1500){
    mx+=0.5;my-=0.5;
  }else if(time%2000 > 1550 && time%2200 < 1950){
    mx-=1;my-=0.5;
  }else if(time%2200 > 2000 && time%2200 < 2199){
  }
  translate(mx,my);
  fill(200);
  s3.drawStage(mx,my);
  p.drawMe();
  p.move();
  p.preMe();
  e.drawE(100);
  hit(e.enemyHit(xP,yP));
  hit(stageHit(xP,yP));
  e.preEHit();
  hit(p.preMHit(xP,yP));
  println(preN);
  pushMatrix();
  fill(0,0,255);
  textSize(100);
  text(time,-100,0);
  if(time > 2300){
    textSize(100);
    text("Clear!",500,0);
    text("RETRY:",500,100);
    text(preN,500,200);
    noLoop();
  }
  popMatrix();
  }////////////////////////////////////////////////////////////////////////////
  else{
    t.display_title();
  
  if(ch.ifdead()) {
    gameFailed();
  } else {
    jud_safe();
  }
  ch.draw_chara();
  st.showBroken();
  }
}
