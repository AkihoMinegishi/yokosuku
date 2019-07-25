class Object {
  int rect_num = 0, elps_num = 0, goal_num = 0;        //*under construction*
  float[][] obrect = new float[512][5];    //*under construction*
  float[][] obelps = new float[512][5];    //*under construction*
  float[][] obgoal = new float[512][5];
  
  void set_rect(float x, float y, float w, float h, float exist) {
    obrect[rect_num][0] = x;
    obrect[rect_num][1] = y;
    obrect[rect_num][2] = w;
    obrect[rect_num][3] = h;
    obrect[rect_num][4] = exist;
    rect_num++;
  }
  void set_elps(float x, float y, float w, float h, float exist) {
    obelps[elps_num][0] = x;
    obelps[elps_num][1] = y;
    obelps[elps_num][2] = w;
    obelps[elps_num][3] = h;
    obelps[elps_num][4] = exist;
    elps_num++;
  }
  void set_goal(float x, float y, float w, float h, float exist) {
    obgoal[goal_num][0] = x;
    obgoal[goal_num][1] = y;
    obgoal[goal_num][2] = w;
    obgoal[goal_num][3] = h;
    obgoal[goal_num][4] = exist;
    goal_num++;
  }
  
  void draw_rect() {
    int i = 0;
    for(i = 0; i < rect_num; i++) {
      if(obrect[i][4] == 1) {
        rect(obrect[i][0], obrect[i][1], obrect[i][2], obrect[i][3]);
      }
    }
  }
  void draw_elps() {
    int i = 0;
    for(i = 0; i < elps_num; i++) {
      if(obelps[i][4] == 1) {
        ellipse(obelps[i][0], obelps[i][1], obelps[i][2], obelps[i][3]);
      }
    }
  }
  void draw_goal() {
    int i = 0;
    for(i = 0; i < goal_num; i++) {
      if(obgoal[i][4] == 1) {
        rect(obgoal[i][0], obgoal[i][1], obgoal[i][2], obgoal[i][3]);
      }
    }
  }
  
  void exist_rect(int id, float exist) {
    obrect[id][4] = exist;
  }
  void exist_elps(int id, float exist) {
    obelps[id][4] = exist;
  }
  void exist_goal(int id, float exist) {
    obgoal[id][4] = exist;
  }
  
  float[] call_rect_status(int i) {
    float status[] = {obrect[i][0] + st[gf.Stage_id].x_pos, obrect[i][1] + st[gf.Stage_id].y_pos, obrect[i][2], obrect[i][3]};
    return status;
  }
  
  float[] call_elps_status(int i) {
    float status[] = {obelps[i][0] + st[gf.Stage_id].x_pos, obelps[i][1] + st[gf.Stage_id].y_pos, obelps[i][2], obelps[i][3]};
    return status;
  }
  
  float[] call_goal_status(int i) {
    float status[] = {obgoal[i][0] + st[gf.Stage_id].x_pos, obgoal[i][1] + st[gf.Stage_id].y_pos, obgoal[i][2], obgoal[i][3]};
    return status;
  }
}
