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
