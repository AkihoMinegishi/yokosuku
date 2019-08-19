class Title {
  int key_config = 0, mark_cnt;
  int pressKey_x = 355, stageN_x = 120, select_st_y = 265, select_st_dy = 30;
  String[][] dir = {{"[UP]", "[LEFT]", "[DOWN]", "[RIGHT]"}, {"[W]", "[A]", "[S]", "[D]"}};
  String[] mes = {"<WASD>", "<arrow key>"};
  boolean knm_command = false;
  boolean if_measure = true, show_unlocking = true, unlock_5th = false, thx4play = false;
  boolean[] if_clear_marks = {false, false, false, false, false};
  
  void display_title() { 
    background(0, 0, 0);
    fill(255);
    textSize(36);
    textAlign(CENTER);
    if(thx4play == false) {
      text("I WANA PLAY THE \"YOKOSUKU\"?", width/2, 70);
    } else {
      fill(255, 255, 64);
      text("THANK YOU FOR PLAYING!!!", width/2, 70);
    }
    textAlign(LEFT);
    textSize(22);
    fill(210, 255, 210);
    text("How to play / change key style", 80, 115);
    text("-press [ENTER]", pressKey_x, 145);
    fill(255, 210, 210);
    text("Save current data", 80, 190);
    text("-press [S]", pressKey_x, 190);
    fill(255);
    text("Game start", 80, 235);
    text("stage1 (tutorial)", stageN_x, select_st_y);
    text("-press [1]",      pressKey_x, select_st_y);
    text("stage2",            stageN_x, select_st_y + select_st_dy);
    text("-press [2]",      pressKey_x, select_st_y + select_st_dy);
    text("stage3",            stageN_x, select_st_y + select_st_dy * 2);
    text("-press [3]",      pressKey_x, select_st_y + select_st_dy * 2);
    text("stage4",            stageN_x, select_st_y + select_st_dy * 3);
    text("-press [4]",      pressKey_x, select_st_y + select_st_dy * 3);
    if(unlock_5th) {
      fill(255, 255, 128);
      text("stage5",            stageN_x, select_st_y + select_st_dy * 4);
      text("-press [5]",      pressKey_x, select_st_y + select_st_dy * 4);
      fill(255);
    }
    
    for(int id = 0; id < 5; id++) {
      int mark_d = 16;
      if(id == 0) fill(128, 255, 128);
      if(id == 1) fill(255, 128, 128);
      if(id == 2) fill(119, 188, 240);
      if(id == 3) fill(192, 192, 255);
      if(id == 4) fill(255, 255, 64);
      if(if_clear_marks[id]) {
        ellipse(stageN_x - mark_d, select_st_y + select_st_dy * id - mark_d / 2, mark_d, mark_d);
      }
    }
    
    if(show_unlocking == true && cnt_clear_marks() >= 4) {
      show_5th();
    }
  }

  void display_how_to_play() {
    background(0, 0, 0);
    fill(255);
    textSize(24);
    text("How to move your "     ,width/10, height*3/20);
    if(knm_command) {
      fill(255, 255, 0);
    }
    text("chara", width/10 + 24*9.25, height*3/20);
    
    fill(255);
    textSize(20);
    text("up",    width/8, height*5/20);
    text("left",  width/8, height*7/20);
    text("down",  width/8, height*9/20);
    text("right", width/8, height*11/20);
    for(int i = 0; i < 4; i++) {
      text("-press ", width/4, height*(i*2+5)/20);
      fill(255, 220, 220);
      text(dir[key_config][i], width*3/8, height*(i*2+5)/20);
      fill(255);
    }
    
    textSize(22);
    fill(255, 220, 220);
    text("press [SHIFT]  ... change style to " + mes[key_config], width/10, height*14/20);
    fill(210, 255, 210);
    text("press [ENTER] ... back to the title" ,width/10, height*17/20);
    fill(255);
    if(knm_command) {
      unlock_5th = true;
    } else if(show_unlocking) {
      unlock_5th = false;
    }
  }

  int cnt_clear_marks() {
    int cnt = 0;
    for(int id = 0; id < 5; id++) {
      if(if_clear_marks[id]) {
        cnt++;
      }
    }
    return cnt;
  }
  
  void set_bolSet(boolean[] sets) {
    knm_command = sets[0];
    show_unlocking = sets[1];
    unlock_5th = sets[2];
    thx4play = sets[3];
  }
  
  void set_clMks(boolean[] mks) {
    for(int i = 0; i < 5; i++) {
      if_clear_marks[i] = mks[i];
    }
  }
}

void show_5th() {
  int show_len = 2000, rCol, gCol, bCol;
  if(ti.if_measure) {
    tm.measure_start();
    ti.if_measure = false;
  }
  rCol = int(255 * (tm.get_passed_time() * 1.0 / show_len));
  gCol = int(255 * (tm.get_passed_time() * 1.0 / show_len));
  bCol = int(128 * (tm.get_passed_time() * 1.0 / show_len));
  fill(rCol, gCol, bCol);
  text("stage5",       ti.stageN_x, ti.select_st_y + ti.select_st_dy * 4);
  text("-press [5]", ti.pressKey_x, ti.select_st_y + ti.select_st_dy * 4);
  if(tm.get_passed_time() > show_len) {
    ti.show_unlocking = false;
    ti.unlock_5th = true;
  }
}

