class GameFlow {
  boolean nowTitle, nowGame, nowClear;
  int nowStage = 0;
  int diecnt = 0;
  
  GameFlow() {
    nowTitle = true;
    nowGame = nowClear = false;
  }
  
  void moveNextStage() {
    nowStage++;
    diecnt = 0;
    nowGame = true;
    nowTitle = nowClear = false;
  }
  
  void dead() {
    diecnt++;
  }
  
  int deadCount() {
    return diecnt;
  }
  
  void allClear() {
    nowClear = true;
    nowTitle = nowGame = false;
  }
}

class Title {
  void display_title() {
    int size = 24;
    String mes = "kusoge";
    background(0);
    textSize(size);
    text(mes, width/2 - size*mes.length()/3, height/2);
  }
  
  boolean askStart() {
    int size = 24;
    String mes = "press Enter";
    text(mes, width/2 - size*mes.length()/3, height * 2 / 3);
    
    if(keyPressed && (keyCode == ENTER)) {
      return true;
    } else {
      return false;
    }
  }
}

class Stage {
  float[] prex = new float[128], 
          prey = new float[128], 
          pred = new float[128];
  int precnt = 0;
  
  void showBg() {
    background(255);
  }
  
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
Title ti = new Title();
Stage st = new Stage();
Chara ch = new Chara();

void keyPressed() {
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

void setup() {
  size(600, 400);
  init_game();
}

void draw() {
  if(gf.nowTitle) {
    ti.display_title();
    if(ti.askStart()) {
      gf.moveNextStage();
    }
  } else if(gf.nowGame) {
    if(ch.ifdead()) {
      gameFailed();
    } else {
      jud_safe();
    }
    ch.draw_chara();
    st.showBroken();
  } else if(gf.nowClear) {
  }
}