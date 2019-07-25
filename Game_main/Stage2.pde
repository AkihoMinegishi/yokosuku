class Stage2 extends Stage{

  void showBg() {
    background(255, 224, 224);
  }

  void events() {
  //change_scroll_direction_and_speed(x_pt, y_pt, new_dx, new_dy, x_dir, y_dir);
    change_scroll_direction_and_speed(0.0,  0.0,  2.0,    0.0,    -1,    0);
  }

  //size(600, 400)


  void set_obj() {
    o.rect_num = o.elps_num = o.goal_num = 0;
    
    //            x     y width height
    //floor
    o.set_rect(   0,  220, 1700,  200, 1); 
    //down_wall
    o.set_rect( 900,  170,  130,   50, 1);
    
    //up_rect
    o.set_rect(   0,    0,  700,  170, 1);
    o.set_rect( 700,    0,  200,  125, 1);
    o.set_rect(2400,    0,  width,  height, 1);
    
    //elps
    o.set_elps( 900,    0, 250, 250, 1);
    o.set_elps(1200,  220, 350, 350, 1);
    o.set_elps(1540,    0, 300, 300, 1);
    for(int x = 1800; x <= 2000; x += 200) {
      for(int y = 0;y <= 400;y += 100) {
        o.set_elps(x, y, 50, 50, 1);
        o.set_elps(x + 100, y - 50, 50, 50, 1);
      }
    }
    
    //goal
    o.set_goal(2200, 0, width, height, 1);
  }
}
