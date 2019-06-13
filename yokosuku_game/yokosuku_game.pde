class Title {
}

abstract class Stage {
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
  float cx, cy, cd = 30.0;
  int life = 3, dam = 3;
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
  }
  
  void gameover() {
    playing = false;
    chcol = color(128, 0, 0);
  }
}

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

void init_game() {
  ch.init();
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
  
  if(ch.ifdead()) {
    ch.gameover();
  }
}

void setup() {
  size(600, 400);
  init_game();
}

void draw() {
  background(255);
  ch.draw_chara();
  jud_safe();
}
