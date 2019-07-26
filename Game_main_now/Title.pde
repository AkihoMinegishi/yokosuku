class Title {
  int key_config = 0;
  String[][] dir = {{"[UP]", "[LEFT]", "[DOWN]", "[RIGHT]"}, {"[W]", "[A]", "[S]", "[D]"}};
  String[] mes = {"<WASD>", "<arrow key>"};
  
  void display_title() {
    background(0, 0, 0);
    fill(255);
    textSize(48);
    text("I WANA (ry"             , 60, 90);
    textSize(24);
    text("How to play / change key style", 80, 160);
    int pressKey_x = 355;
    text("-press [ENTER]", pressKey_x, 200);
    
    text("Game start", 80, 240);
    int stageN_x = 120;
    text("stage1 (tutorial)", stageN_x, 275);
    text("-press [1]",      pressKey_x, 275);
    text("stage2",            stageN_x, 305);
    text("-press [2]",      pressKey_x, 305);
    text("stage3",            stageN_x, 335);
    text("-press [3]",      pressKey_x, 335);
    text("stage4",            stageN_x, 365);
    text("-press [4]",      pressKey_x, 365);
  }

  void display_how_to_play() {
    background(0, 0, 0);
    fill(255);
    textSize(24);
    text("How to move your chara"     ,width/10, height*3/20);
    
    textSize(20);
    text("up",    width/8, height*5/20);
    text("left",  width/8, height*7/20);
    text("down",  width/8, height*9/20);
    text("right", width/8, height*11/20);
    for(int i = 0; i < 4; i++) {
      text("-press " + dir[key_config][i], width/4, height*(i*2+5)/20);
    }
    
    textSize(22);
    text("press [SHIFT]  ... change style to " + mes[key_config], width/10, height*14/20);
    
    text("press [ENTER] ... back to the title" ,width/10, height*17/20);
  }

}
