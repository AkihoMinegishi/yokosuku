/*
methods::
 relate_child_class:
   [abstract_method]showBg:show_background
 un-relate_child_class:
   drawBrokenChara:draw_broken_characters
   inputBrokenCharaStatus:memorize_character's_broken_point_as_matrix
   callBrokenCharaStatus:return BrokenCharaStatus as matrix(1D)
*/

abstract class Stage {
  Object o = new Object();
  
  /*====================================
    x_pos       :描画時のx座標軸の位置
    y_pos       :描画時のy座標軸の位置
    dx          :x方向のスクロール度合い
    dy          :y方向のスクロール度合い
    x_direction :x軸のスクロール方向
    y_direction :y軸のスクロール方向
  ====================================*/
  float x_pos, y_pos;
  float dx, dy;
  int x_direction, y_direction;
  color object_col, broken_col, goal_col;
  //only for stage4
  int ms;
  float fall_y;
  boolean chara_white = false, chara_stop = false, chara_is_alive;
  
  void init_stage() {
    x_pos  = 0;
    y_pos = 0;
    dx = 2;
    dy = 0;
    x_direction = -1;
    y_direction = 0;
    object_get_color();
    goal_col = color(255, 255, 128);
    
    ms = 0;
    fall_y = 0.0;
    chara_white = false;
    chara_stop = false;
    chara_is_alive = true;
  }
  
  //自動スクロールの方向と速度変更
  void change_scroll_direction_and_speed(float x_pt, float y_pt, float new_dx, float new_dy, int x_dir, int y_dir) {
    if(-x_pos == x_pt && -y_pos == y_pt) {
      dx = new_dx;
      dy = new_dy;
      x_direction = x_dir;
      y_direction = y_dir;
    }
  }
  
  //stop all abjects
  void stop_stage() {
    chara_is_alive = false;
    dx = 0;
    dy = 0;
  }
  
  void object_white_out(int cmd) {
    if(cmd == 0) {
      object_col = broken_col = color(240, 240, 240);
    } else if(cmd == 1) {
      object_col = broken_col = color(255, 255, 255);
    }
  }
  void object_get_color() {
    object_col = color(0, 100, 130);
    broken_col = color(128, 0, 0);
  }
  
  // only for stage4
  /*void white_out_trap(boolean bo) {
    chara_white = bo;
  }*/
  void chara_stop_trap(boolean bo) {
    chara_stop = bo;
  }
  float[] txtrect_status() {
    float[] rc = {0, 0, 0, 0};
    return rc;
  }

  void display() {
    pushMatrix();             //元描画座標軸の保管
    translate(x_pos, y_pos);  //描画座標軸の変換
    
    noStroke();
    fill(goal_col);
    o.draw_goal();
    stroke(0);
    
    fill(object_col);
    o.draw_elps();
    o.draw_rect();
    
    popMatrix();              //元描画座標軸の呼び出し
    x_pos += dx * x_direction;
    y_pos += dy * y_direction;
  }
  
  abstract void events();        //about_scroll_change_etc...
  
  abstract void showBg();        //show_background
  
  abstract void set_obj();       //set_objects

//=================================================================================================//
//"broken"_processing//
//=================//
  float[] prex = new float[128], 
          prey = new float[128], 
          pred = new float[128];
  int precnt = 0;


  void drawBrokenChara() {
    for(int i = 0; i < precnt; i++) {
      fill(broken_col);
      ellipse(prex[i], prey[i], pred[i], pred[i]);
    }
  }
  
  void inputBrokenCharaStatus(float px, float py, float pd) {
    prex[precnt] = px;
    prey[precnt] = py;
    pred[precnt] = pd;
    precnt++;
  }
  
  //get broken number i position
  float[] callBrokenCharaStatus(int i) {
    float sets[] = {prex[i], prey[i], pred[i], pred[i]};
    return sets;
  }
  
  //reset broken
  void reset_broken() {
    for(int i = 0; i < precnt; i++) {
      prex[i] = prey[i] = pred[i] = 0;
    }
    precnt = 0;
  }
//=================================================================================================//

}
