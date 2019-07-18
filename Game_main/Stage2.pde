class Stage2 extends Stage{

  void showBg() {
    background(255, 224, 224);
  }


  //size(600, 400)


  void set_obj() {
    //            x     y width height
    o.set_rect(   0,  220, 3000,  200); //floor
    //down_wall
    o.set_rect( 900,  170,  130,   50);
    
    //up_rect
    o.set_rect(   0,    0,  700,  170);
    o.set_rect( 700,    0,  200,  125);
    
    //elps
    o.set_elps( 900,    0, 250, 250);
    o.set_elps(1200,  220, 350, 300);
    o.set_elps(1540,    0, 300, 250);
    
    //goal
    o.set_goal(999999.0, 999999.0, width, height);
  }
}
