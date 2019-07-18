class Object {
  int rect_num = 0, elps_num = 0;                        //*under construction*
  float[][] obrect = new float[128][4];    //*under construction*
  float[][] obelps = new float[128][4];    //*under construction*
  float[] obgoal = new float[4];
  
  void set_rect(float x, float y, float w, float h) {
    obrect[rect_num][0] = x;
    obrect[rect_num][1] = y;
    obrect[rect_num][2] = w;
    obrect[rect_num][3] = h;
    rect_num++;
  }
  void set_elps(float x, float y, float w, float h) {
    obelps[elps_num][0] = x;
    obelps[elps_num][1] = y;
    obelps[elps_num][2] = w;
    obelps[elps_num][3] = h;
    elps_num++;
  }
  void set_goal(float x, float y, float w, float h) {
    obgoal[0] = x;
    obgoal[1] = y;
    obgoal[2] = w;
    obgoal[3] = h;
  }
  
  void draw_rect() {
    int i = 0;
    for(i = 0; i < rect_num; i++) {
      rect(obrect[i][0], obrect[i][1], obrect[i][2], obrect[i][3]);
    }
  }
  void draw_elps() {
    int i = 0;
    for(i = 0; i < elps_num; i++) {
      ellipse(obelps[i][0], obelps[i][1], obelps[i][2], obelps[i][3]);
    }
  }
  void draw_goal() {
    rect(obgoal[0], obgoal[1], obgoal[2], obgoal[3]);
  }
  
  float[] call_rect_status(int i) {
    float status[] = {obrect[i][0] + st[gf.Stage_id].x_pos, obrect[i][1] + st[gf.Stage_id].y_pos, obrect[i][2], obrect[i][3]};
    return status;
  }
  
  float[] call_elps_status(int i) {
    float status[] = {obelps[i][0] + st[gf.Stage_id].x_pos, obelps[i][1] + st[gf.Stage_id].y_pos, obelps[i][2], obelps[i][3]};
    return status;
  }
  
  float[] call_goal_status() {
    float status[] = {obgoal[0] + st[gf.Stage_id].x_pos, obgoal[1] + st[gf.Stage_id].y_pos, obgoal[2], obgoal[3]};
    return status;
  }
}
