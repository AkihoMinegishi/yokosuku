class Stage1 extends Stage{
  int object_1 = 13, object_2 = 13;
  
  void init_stage_for_each() {
  }
  
  void showBg() {
    background(255, 255, 224);
  }
  
  void events() {
  //change_scroll_direction_and_speed(x_pt,   y_pt, new_dx, new_dy, x_dir, y_dir);
    change_scroll_direction_and_speed(0.0,    0.0,  2.0,    0.0,    -1,    0);
    
    for(int id = object_1; id <= object_1 + object_2 - 1; id++) {
      if(620 <= -x_pos) {
        o.exist_elps(id, 1);
        o.exist_rect(id, 1);
      }
    }
    
    change_scroll_direction_and_speed(1200,   0.0,  2.25,   0.0,    -1,    0);
    
    if(1300 <= -x_pos) {
      int prev_id = object_1 + object_2;
      o.exist_elps(prev_id,      0);
      o.exist_elps(prev_id + 3,  0);
      o.exist_elps(prev_id + 6,  0);
      o.exist_elps(prev_id + 9,  0);
      o.exist_elps(prev_id + 12, 0);
      o.exist_rect(prev_id + 14, 0);
      o.exist_rect(prev_id + 16, 0);
      o.exist_rect(prev_id + 18, 0);
      o.exist_rect(prev_id + 20, 0);
      o.exist_rect(prev_id + 22, 0);
    }
    
    change_scroll_direction_and_speed(1726.5, 0.0,  2.25,   2.0,    0,     -1);
    change_scroll_direction_and_speed(1726.5, 4.0,  2.25,   2.0,    -1,    0);
  }
  
  void set_obj() {
    o.rect_num = o.elps_num = o.goal_num = 0;
    
    for(int i = 0; i < object_1; i++) {
      o.set_elps(width + random(width) * 0.75, random(height), 20, 20, 1); //width * 1.75 = 1050
      o.set_rect(width + random(width) * 0.75, random(height), 20, 20, 1);
    }
    for(int i = 0; i < object_2; i++) {
      o.set_elps(width * 1.75 + random(width) * 0.75, random(height), 20, 20, 0); //width * 2.5 = 1500
      o.set_rect(width * 1.75 + random(width) * 0.75, random(height), 20, 20, 0);
    }
    
    for(int i = 0; i < 10; i++) {
       for(int j = 0; j < 5; j++) {
         if((i + j) % 2 == 0) {
           o.set_elps(1600+(90*i) + 20, 40+(70*j) + 20, 40, 40, 1);
         } else {
           o.set_rect(1600+(90*i),      40+(70*j),      40, 40, 1);
         }
       }
    }
    
    for(int i = 0; i < 10; i++) {
      if(i < 8) {
        o.set_rect(width + 200*i, 0,                 200, 5*(i+1),     1); //seil
        o.set_rect(width + 200*i, height - 5*(i+1),  200, 5*(i+1)+100, 1); //floor
      } else {
        o.set_rect(width + 200*i, 0,                 200, 5*8,     1); //seil
        o.set_rect(width + 200*i, height - 5*(i+1),  200, 5*8+100, 1); //floor
      }
    }
    
    //goal
    o.set_goal(2600, 0.0, width, height * 1.5, 1); //
  }
}
