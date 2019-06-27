class Enemy{
  float [][] enemys = new float[100][100];
  float [] sizeE = new float[100];
  float xE;
  float yE;
  void setE(int n){
    for(int i = 0;i < n;i++){
      xE = (random(-600,600));
      yE = (random(-600,600));
      sizeE[i] = (random(50));
      enemys[i][0] = xE;
      enemys[i][1] = yE;
      //ellipse(enemys[i][0],enemys[i][1],sizeE[i],sizeE[i]);
    }
  }
  void drawE(int n){
    for(int i = 0;i < n;i++){
      ellipse(enemys[i][0],enemys[i][1],sizeE[i],sizeE[i]);
    }
  }
}
