class Stage2 extends Stage{

  void showBg() {
    background(255, 224, 224);
  }


  //size(600, 400)


  void set_obj() {
    //            x     y width height
    //floor
    o.set_rect(   0,  220, 1700,  200); 
    //down_wall
    o.set_rect( 900,  170,  130,   50);
    
    //up_rect
    o.set_rect(   0,    0,  700,  170);
    o.set_rect( 700,    0,  200,  125);
    
    //elps
    o.set_elps( 900,    0, 250, 250);
    o.set_elps(1200,  220, 350, 350);
    o.set_elps(1540,    0, 300, 300);
    for(int x = 1800; x <= 2000; x += 200) {
      for(int y = 0;y <= 400;y += 100) {
        o.set_elps(x, y, 50, 50);
        o.set_elps(x + 100, y - 50, 50, 50);
      }
    }
  }
}
