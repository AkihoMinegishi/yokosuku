class Stage1 extends Stage{
  
  void showBg() {
    background(255, 255, 224);
  }
  
  void events() {
  //change_scroll_direction_and_speed(x_pt,   y_pt, new_dx, new_dy, x_dir, y_dir);
    change_scroll_direction_and_speed(0.0,    0.0,  2.0,    0.0,    -1,    0);
    if(620 <= -x_pos) {
      for(int id = 12; id <= 23; id++) {
        o.exist_elps(id, 1);
        o.exist_rect(id, 1);
      }
    } else {
      for(int id = 12; id <= 23; id++) {
        o.exist_elps(id, 0);
        o.exist_rect(id, 0);
      }
    }
    change_scroll_direction_and_speed(900,    0.0,  2.25,   0.0,    -1,    0);   //width * 1.5 = 900
    change_scroll_direction_and_speed(1201.5, 0.0,  2.25,   2.0,    0,     -1);  //width * 2.0 = 1200;
    change_scroll_direction_and_speed(1201.5, 4.0,  2.25,   2.0,    -1,    0);
  }
  
  void set_obj() {
    o.rect_num = o.elps_num = o.goal_num = 0;
    
    for(int i = 0; i < 12; i++) {
      o.set_elps(width + random(width) * 0.75, random(height), 20, 20, 1); //id 0~11
      o.set_rect(width + random(width) * 0.75, random(height), 20, 20, 1); //id 0~11
    }
    for(int i = 0; i < 12; i++) {
      o.set_elps(width * 1.75 + random(width) * 0.75, random(height), 20, 20, 0); //id 12~23
      o.set_rect(width * 1.75 + random(width) * 0.75, random(height), 20, 20, 0); //id 12~23
    }
    
    for(int i = 0; i < 8; i++) {
      o.set_rect(width + 200*i, 0,                 200, 5*(i+1),     1); //seil    id 24~31
      o.set_rect(width + 200*i, height - 5*(i+1),  200, 5*(i+1)+100, 1); //floor   id 24~31
    }
    
    //goal
    o.set_goal(width * 2.75, 0.0, width, height * 1.5, 1); //id 0
  }
}
