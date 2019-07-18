class Stage4 extends Stage{

  void showBg() {
    background(224, 224, 255);
  }
  
  void set_obj() {
    
    
    for(int x = 1800; x <= 2000; x += 200) {
      for(int y = 0;y <= 400;y += 100) {
        o.set_elps(x, y, 50, 50);
        o.set_elps(x + 100, y - 50, 50, 50);
      }
    }
    
    //goal
    o.set_goal(2200, 0, width, height);
  }

}
