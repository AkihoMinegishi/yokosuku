class Stage4 extends Stage{
  float x_goal = 9999999.0;
  float y_goal = 9999999.0;
  
  boolean ifClear() {
    if(x_pos * -1 == x_goal && y_pos * -1 == y_goal) {
      return true;
    } else {
      return false;
    }
  }

  void showBg() {

    background(224, 224, 255);

  }
  
  void set_obj() {
  }

}
