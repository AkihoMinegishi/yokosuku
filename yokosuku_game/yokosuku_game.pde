class GameFlow {
  boolean nowTitle, nowGame, nowClear, pressedEnter; //judge statement
  int nowStage = 0; //stage number
  int diecnt = 0; //counting death(reseted by moving stage)
  
  GameFlow() {
    nowTitle = true;
    nowGame = nowClear = false;
  }
  
  //reset die count and warp stage
  void warpStage(int dir) {
    nowStage = dir;
    diecnt = 0;
    nowGame = true;
    nowTitle = nowClear = false;
  }
  
  //+1 die count
  void dead() {
    diecnt++;
  }
  
  //get die count
  int deadCount() {
    return diecnt;
  }
  
  //move to the end of the game
  void allClear() {
    nowClear = true;
    nowTitle = nowGame = false;
  }
}

class Title {
  void display_title() {
    int size = 24;
    String mes = "game";
    background(0);
    textSize(size);
    text(mes, width/2 - size*mes.length()/3, height/2);
  }
}

abstract class Stage {
  int rectN, elpsN;
  float[] obrect = new float[128][4];
  float[] obelps = new float[128][4];
  float[] prex = new float[128], 
          prey = new float[128], 
          pred = new float[128];
  int precnt = 0;
  
  abstract void showBg();
  
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
  
  float[] callBrokenPoint(int i) {
    float sets[] = {prex[i], prey[i], pred[i], pred[i]};
    return sets;
  }
}

class Stage1 extends Stage{
  void showBg() {
    background(255, 255, 224);
  }
}

class Stage2 extends Stage{
  obrect[0] = {width, width + 1.0, 0.0, height};
  obrect[1] = {-1.0, 0.0, 0.0, height};
  obrect[2] = {0.0, width, -1.0, 0.0},
  obrect[3] = {0.0, width, height, height + 1.0}};
                       
  void showBg() {
    background(255, 224, 224);
  }
}

class Stage3 extends Stage{
  void showBg() {
    background(224, 255, 224);
  }
}

class Stage4 extends Stage{
  void showBg() {
    background(224, 224, 255);
  }
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
      playing = false;
      chcol = color(128, 0, 0);
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
}

GameFlow gf = new GameFlow();
Title ti = new Title();
Stage[] st = new Stage[4];
Chara ch = new Chara();

void keyPressed() {
  char[] st = {'1', '2', '3', '4'};
  if(gf.nowTitle) {
    for(int i = 0; i < 4; i++) {
      if(key == st[i]) {
        gf.warpStage(i);
        init_game();
      }
    }
  }
  
  if(gf.nowGame) {
    float step = 5.0;
    if(keyCode == RIGHT) {
      ch.move_chara(step, 0);
    }
    if(keyCode == LEFT) {
      ch.move_chara(-step, 0);
    }
    if(keyCode == UP) {
      ch.move_chara(0, -step);
    }
    if(keyCode == DOWN) {
      ch.move_chara(0, step);
    }
  }
}

void keyReleased() {
}

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
    st[gf.nowStage].inputPre(ch.cx, ch.cy, ch.cd);
    init_game();
  }
}

void gameFailed() {
  showMessage("You Lose :(", 28, width / 2, height / 2);
  askContinue();
}

void jud_safe(int st) {
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
    if(ch.ifsafe_elps(st[gf.nowStage].callBrokenPoint(i)) == false) {
      ch.damage();
      if(ch.ifdead()) {
        break;
      }
    }
  }
}

void setup() {
  size(600, 400);
  
  st[0] = new Stage1();
  st[1] = new Stage2();
  st[2] = new Stage3();
  st[3] = new Stage4();
  
  init_game();
}

void draw() {
  if(gf.nowTitle) {
    ti.display_title();
  } else if(gf.nowGame) {
    st[gf.nowStage].showBg();
    
    ch.draw_chara();
    st[gf.nowStage].showBroken();
    
    if(ch.ifdead()) {
      gameFailed();
    } else {
      jud_safe(gf.nowStage);
    }
  } else if(gf.nowClear) {
  }
}
