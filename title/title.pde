class Title {
  
  void display_title() {
    background(0,0,0);
    textSize(24);
    text("クソゲー", width/3, height/2);
  }
}

Title t;

void setup() {
  t = new Title();
  size(200, 200);
}

void draw() {
  t.display_title();
}
