class Stage2 extends Stage{
  obrect[0] = {width, width + 1.0, 0.0, height};
  obrect[1] = {-1.0, 0.0, 0.0, height};
  obrect[2] = {0.0, width, -1.0, 0.0};
  obrect[3] = {0.0, width, height, height + 1.0};
                       
  void showBg() {
    background(255, 224, 224);
  }
}
