class Title {
  int key_config = 0;
  String[][] dir = {{"[UP]", "[LEFT]", "[DOWN]", "[RIGHT]"}, {"[W]", "[A]", "[S]", "[D]"}};
  String[] mes = {"<WASD>", "<arrow key>"};
  
  void display_title() {
    background(0, 0, 0);
    fill(255);
    textSize(48);
    text("I WANNA (ry"             , 80, 100);
    textSize(24);
    text("How to play / change key style", 100, 170);
    int pressKey_x = 375;
    text("-press [H]", pressKey_x, 205);
    
    text("Game start", 100, 250);
    int stageN_x = 140;
    text("stage1 (tutorial)", stageN_x, 285);
    text("-press [1]",      pressKey_x, 285);
    text("stage2",            stageN_x, 315);
    text("-press [2]",      pressKey_x, 315);
    text("stage3",            stageN_x, 345);
    text("-press [3]",      pressKey_x, 345);
    text("stage4",            stageN_x, 375);
    text("-press [4]",      pressKey_x, 375);
  }

  void display_how_to_play() {
    background(0, 0, 0);
    fill(255);
    textSize(24);
    text("How to move your chara"     ,width/10, height*1/10);
    
    textSize(20);
    text("up",    width/8, height*2/10);
    text("left",  width/8, height*3/10);
    text("down",  width/8, height*4/10);
    text("right", width/8, height*5/10);
    for(int i = 0; i < 4; i++) {
      text("-press " + dir[key_config][i], width/4, height*(i+2)/10);
    }
    
    textSize(22);
    text("press [SHIFT]  ... change style to " + mes[key_config], width/10, height*14/20);
    
    text("press [ENTER] ... back to the title" ,width/10, height*17/20);
  }

}
