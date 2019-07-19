class Stage4 extends Stage {
  color nor = color(240, 240, 255);
  
  void showBg() {
    background(nor);
  }
  
  float[] txtrect_status() {
    float[] rc = {20, 25+fall_y, 285, 75};
    return rc;
  }
  
  void sayo_nara_event() {
    change_scroll_direction_and_speed(width / 3.0,  0.0,  2.0,    0.0,    0,    0);
    white_out_trap(true);
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
    if(ms >= 6000 && chara_is_alive) {
      chara_stop_trap(false);
    }
    if(ms >= 8000 && chara_is_alive) {
      fall_y += 20;
    }
    if(ms >= 9000 && chara_is_alive) {
      white_out_trap(false);
      object_get_color();
      x_pos = -(width / 3 + 2.0);
    }
  }
  
  void events() {
  //change_scroll_direction_and_speed(x_pt, y_pt, new_dx, new_dy, x_dir, y_dir);
    change_scroll_direction_and_speed(0.0,  0.0,  2.0,    0.0,    -1,    0);
    if(-x_pos == 200) {
      ms = millis();
      sayo_nara_event();
    }
    ms = 0;
    change_scroll_direction_and_speed(width / 3 + 2.0,  0.0,  2.0,    0.0,    -1,    0);
    change_scroll_direction_and_speed(1450.0, 0.0, 2.5, 0.0, 1, 0);
    change_scroll_direction_and_speed(1142.5, 0.0, 2.5, 1.0, 0, -1);
    change_scroll_direction_and_speed(1142.5, 40.0, 3.0, 1.0, -1, -1);
  }
  
  void set_obj() {
    o.set_rect(520, 0, 400, height / 5 * 2);
    o.set_rect(520, height - height / 5 * 2, 400, height / 5 * 2);
    
    o.set_rect(1020, 50,  100, 300);
    o.set_rect(1200, 0,   100, 150);
    o.set_rect(1200, 250, 100, 150);
    
    o.set_elps(1575, height / 2, 150, 150);
    for(int i = 0; i < 16; i++) {
      float cenx = 1575, ceny = height / 2;
      o.set_elps(cenx + cos(PI * i / 8) * 175, ceny + sin(PI * i / 8) * 175, 20, 20);
    }
    
    o.set_rect(1900, 600, 1000, 600);
    //goal
    o.set_goal(2200, 0 + 100, width, height + 200);
  }

}
