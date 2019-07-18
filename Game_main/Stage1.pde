class Stage1 extends Stage{
  float x_goal = width * 2.5;
  float y_goal = 0.0;
  
  boolean ifClear() {
    if(x_pos * -1 == x_goal && y_pos * -1 == y_goal) {
      return true;
    } else {
      return false;
    }
  }
  
  void showBg() {
    background(255, 255, 224);
  }
  
  void set_obj() {
    for(int i = 0; i < 20; i++) {
      o.set_elps(width + random(width) * 1.5, random(height), 30, 30);
      o.set_rect(width + random(width) * 1.5, random(height), 30, 30);

    }
  }
}
