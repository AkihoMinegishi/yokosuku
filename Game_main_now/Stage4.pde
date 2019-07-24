class Stage4 extends Stage {
  float fall_y;
  boolean chara_white, chara_stop; 
  color nor = color(240, 240, 255);
  
  void init_stage() {
    x_pos  = 0;
    y_pos = 0;
    dx = 2;
    dy = 0;
    x_direction = -1;
    y_direction = 0;
    object_get_color();
    goal_col = color(255, 255, 128);
    chara_is_alive = true;
    
    fall_y = 0.0;
    chara_white = false;
    chara_stop = false;
  }
  
  void showBg() {
    background(nor);
  }
  
  void white_out_trap(boolean bo) {
    chara_white = bo;
  }
  void chara_stop_trap(boolean bo) {
    chara_stop = bo;
  }
  
  float[] txtrect_status() {
    float[] rc = {20, 25+fall_y, 285, 75};
    return rc;
  }
  
  void sayo_nara_event() {
    change_scroll_direction_and_speed(200, 0.0, 2.0, 0.0, 0, 0);
    //white_out_trap(true);
    chara_white = true;
    chara_stop_trap(true);
    object_white_out(1);
    background(255);
    noFill();
    noStroke();
    rect(20, 25+fall_y, 285, 75);
    stroke(0);
    fill(0);
    textSize(18);
    text("An exception has occured.", 20, 40+fall_y);
    text("File\"Game_main/Stage4\", line 21", 20, 70+fall_y);
    text("See traceback.txt for details.", 20, 100+fall_y);
    noFill();
    if(chara_is_alive) {
      if(passed_time >= 6000) {
        chara_stop_trap(false);
      }
      if(passed_time >= 8000) {
        fall_y += 20;
      }
      if(passed_time >= 9000) {
        //white_out_trap(false);
        chara_white = true;
        object_get_color();
        x_pos = -(200 + 2.0);
      }
    }
  }
  
  void events() {
  //change_scroll_direction_and_speed(x_pt, y_pt, new_dx, new_dy, x_dir, y_dir);
    change_scroll_direction_and_speed(0.0,  0.0,  2.0,    0.0,    -1,    0);
    if(200.0 <= -x_pos && -x_pos < 202.0) {
      sayo_nara_event();
    }
    change_scroll_direction_and_speed(width / 3 + 2.0,  0.0,  2.0,    0.0,    -1,    0);
    change_scroll_direction_and_speed(1450.0, 0.0, 2.5, 0.0, 1, 0);
    change_scroll_direction_and_speed(1142.5, 0.0, 2.5, 1.0, 0, -1);
    change_scroll_direction_and_speed(1142.5, 40.0, 3.0, 1.0, -1, -1);
  }
  
  void set_obj() {
    o.set_rect(520, 0, 400, height / 5 * 2, 1); //id 0
    o.set_rect(520, height - height / 5 * 2, 400, height / 5 * 2, 1); //id 1
    
    o.set_rect(1020, 50,  100, 300, 1); //id 2~4
    o.set_rect(1200, 0,   100, 150, 1);
    o.set_rect(1200, 250, 100, 150, 1);
    
    o.set_elps(1575, height / 2, 150, 150, 1); //id 0
    for(int i = 0; i < 16; i++) {
      float cenx = 1575, ceny = height / 2;
      o.set_elps(cenx + cos(PI * i / 8) * 175, ceny + sin(PI * i / 8) * 175, 20, 20, 1); //id 1~16
    }
    
    o.set_rect(1900, 600, 1000, 600, 1); //id 5
    //goal
    o.set_goal(2200, 0 + 100, width, height + 200, 1); //id 0
  }

}
