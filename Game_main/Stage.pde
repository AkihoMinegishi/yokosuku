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
  int rectN, elpsN;
  float[][] obrect = new float[128][4];    //*under cinstruction*
  float[][] obelps = new float[128][4];    //*under cinstruction*
  float[] prex = new float[128], 
          prey = new float[128], 
          pred = new float[128];
  int precnt = 0;
  
  abstract void showBg();
  
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
  
  //i番目に死んだキャラの座標情報を1次元配列として取得
  float[] callBrokenCharaStatus(int i) {
    float sets[] = {prex[i], prey[i], pred[i], pred[i]};
    return sets;
  }
}
