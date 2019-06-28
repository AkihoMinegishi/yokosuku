class Title {
  
  void display_title() {
    background(0,0,0);
    textSize(48);
    text("I WANNA (ry"             ,width/5, height/3);
    textSize(24);
    text("How to play -press H"    ,width/5, height*6/9);
    text("Game start  -press ENTER",width/5, height*7/9);
  }
  void display_how_to_play() {
    background(0,0,0);
    textSize(24);
    text("move your chara"     ,width/5, height*1/9);
    text("up       -press UP"  ,width/5, height*2/9);
    text("down  -press DOWN"   ,width/5, height*3/9);
    text("left     -press LEFT",width/5, height*4/9);
    text("right   -press RIGHT",width/5, height*5/9);
    
    text("Are you ready?  -press ENTER " ,width/5, height*7/9);
  }
}

Title t;

void setup() {
  t = new Title();
  size(600, 400);
}

void draw() {
  t.display_how_to_play();
}
