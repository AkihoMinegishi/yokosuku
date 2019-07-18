class Stage1 extends Stage{
  
  void showBg() {
    background(255, 255, 224);
  }
  
  void events() {
  //change_scroll_direction_and_speed(x_pt,              y_pt, new_dx, new_dy, x_dir, y_dir);
    change_scroll_direction_and_speed(0.0,               0.0,  2.0,    0.0,    -1,    0);
    change_scroll_direction_and_speed(width * 1.5,       0.0,  2.25,   0.0,    -1,    0);   //width * 1.5 = 900
    change_scroll_direction_and_speed(width * 2.0 + 1.5, 0.0,  2.25,   2.0,    0,     -1);  //width * 2.0 = 1200;
    change_scroll_direction_and_speed(width * 2.0 + 1.5, 4.0,  2.25,   2.0,    -1,    0);
  }
  
  void set_obj() {
    for(int i = 0; i < 8; i++) {
      o.set_rect(width + 200*i, 0,                 200, 5*(i+1));     //seil
      o.set_rect(width + 200*i, height - 5*(i+1),  200, 5*(i+1)+100); //floor
    }
    
    for(int i = 0; i < 22; i++) {
      o.set_elps(width + random(width) * 1.5, random(height), 20, 20);
      o.set_rect(width + random(width) * 1.5, random(height), 20, 20);
    }
    //goal
    o.set_goal(width * 2.75, 0.0, width, height * 1.5);
  }
}
