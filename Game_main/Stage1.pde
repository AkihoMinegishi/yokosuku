class Stage1 extends Stage{

  void showBg() {
    background(255, 255, 224);
  }
  
  void set_obj() {
    for(int i = 0; i < 20; i++) {
      o.set_elps(width / 3.0 + random(width) * 1.5, random(height), 30, 30);
      o.set_rect(width / 3.0 + random(width) * 1.5, random(height), 30, 30);

    }
  }
}
