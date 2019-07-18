class Stage1 extends Stage{
  
  void showBg() {
    background(255, 255, 224);
  }
  
  void set_obj() {
    for(int i = 0; i < 20; i++) {
      o.set_elps(width + random(width) * 1.5, random(height), 20, 20);
      o.set_rect(width + random(width) * 1.5, random(height), 20, 20);

    }
    //goal
    o.set_goal(width * 2.5, 0.0, width, height);
  }
}
