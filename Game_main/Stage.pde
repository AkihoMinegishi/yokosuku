/*****************************************************************
methods:::
 relate_child_class::
   [abstract_method]showBg:  show_background
   [abstract_method]set_obj: set_object's_status

 un-relate_child_class::
   drawBrokenChara:          draw_broken_characters
   inputBrokenCharaStatus:   memorize_character's_broken_point_as_matrix
   callBrokenCharaStatus:    return BrokenCharaStatus as matrix(1D)
*****************************************************************/

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
  float x_pos = 0;
  float y_pos = 0;  
  int dx = 2;
  int dy = 1;
  int x_direction = -1;
  int y_direction = 0;
  
  //自動スクロールの方向変更
  void change_scroll_direction(int id) {
    int[] x_directions = { 1, 1, 0,-1,-1,-1, 0, 1};
    int[] y_directions = { 0, 1, 1, 1, 0,-1,-1, 1};
    x_direction = x_directions[id];
    y_direction = y_directions[id];
  }
  
  void display() {
    fill(0,100,130);
    pushMatrix();             //元描画座標軸の保管
    translate(x_pos, y_pos);  //描画座標軸の変換
    o.draw_elps();
    o.draw_rect();
    popMatrix();              //元描画座標軸の呼び出し
    x_pos += dx * x_direction;
    y_pos += dy * y_direction;
  }
  
  
  abstract void showBg();       //show_background
  
  abstract void set_obj();      //set_objects



//=================================================================================================//
//"broken"_processing//
//=================//
  float[] prex = new float[128], 
          prey = new float[128], 
          pred = new float[128];
  int precnt = 0;


  void drawBrokenChara() {
    for(int i = 0; i < precnt; i++) {
      fill(128, 0, 0);
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
//=================================================================================================//

}
