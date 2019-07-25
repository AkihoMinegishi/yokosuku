class Stage3 extends Stage{

  void init_stage_for_each() {
  }
  
  void showBg() {
    background(224, 255, 224);
  }
  
  void events() {
  //change_scroll_direction_and_speed(x_pt, y_pt, new_dx, new_dy, x_dir, y_dir);
  }
  
  void set_obj() {
    o.rect_num = o.elps_num = o.goal_num = 0;
    
    //goal
    o.set_goal(999999.0, 999999.0, width, height, 1);
  }

}
