class Title {

  void display_title() {
    background(0, 0, 0);
    fill(255);
    textSize(48);
    text("I WANNA (ry"             ,100, 100);
    textSize(24);
    text("How to play -press H"    ,150, 200);
    text("Game start"              ,150, 250);
    text("     tutorial    -press 1"    ,150, 275);
    text("     stage1     -press 2"    ,150, 300);
    text("     stage2     -press 3"    ,150, 325);
    text("     stage3     -press 4"    ,150, 350);

  }

  void display_how_to_play() {
    background(0, 0, 0);
    fill(255);
    textSize(24);
    text("move your chara"     ,width/5, height*1/9);
    text("up       -press UP"  ,width/5, height*2/9);
    text("down  -press DOWN"   ,width/5, height*3/9);
    text("left     -press LEFT",width/5, height*4/9);
    text("right   -press RIGHT",width/5, height*5/9);
    text("back to title    -press ENTER " ,width/5, height*7/9);
  }

}
