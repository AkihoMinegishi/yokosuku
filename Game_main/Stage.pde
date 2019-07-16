abstract class Stage {
  int rectN, elpsN;
  float[][] obrect = new float[128][4];
  float[][] obelps = new float[128][4];
  float[] prex = new float[128], 
          prey = new float[128], 
          pred = new float[128];
  int precnt = 0;
  
  abstract void showBg();
  
  void showBroken() {
    for(int i = 0; i < precnt; i++) {
      fill(128, 0, 0);
      ellipse(prex[i], prey[i], pred[i], pred[i]);
    }
  }
  
  void inputPre(float px, float py, float pd) {
    prex[precnt] = px;
    prey[precnt] = py;
    pred[precnt] = pd;
    precnt++;
  }
  
  float[] callBrokenPoint(int i) {
    float sets[] = {prex[i], prey[i], pred[i], pred[i]};
    return sets;
  }
}
