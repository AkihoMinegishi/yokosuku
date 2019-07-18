class Stage1 extends Stage{

  void showBg() {
    background(255, 255, 224);
  }
  
  void set_obj() {
    for(int i = 0; i < 10; i++) {
      o.set_elps(random(width) * 2.0,random(height),30,30);
      o.set_rect(random(width) * 2.0,random(height),30,30);

    }
  }
}
