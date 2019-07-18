class Enemy{
  float [][] enemys = new float[100][2];
  float [] sizeE = new float[100];
  float [] R = new float[100];
  boolean[] h = new boolean[100];
  float xE;
  float yE;
  float[] angle = new float[100];
  void setE(int n){
    for(int i = 0;i < n;i++){
      if(i < n/2){
      xE = (random(-600,-300));
      yE = (random(-600,-300));
      }else{
        xE = (random(300,600));
        yE = (random(300,600));
      }
      sizeE[i] = (random(10,50));
      enemys[i][0] = xE;
      enemys[i][1] = yE;
      R[i] = dist(0,0,xE,yE);
      angle[i] = random(100);
      //ellipse(enemys[i][0],enemys[i][1],sizeE[i],sizeE[i]);
    }
  }
  void drawE(int n){
    for(int i = 0;i < n;i++){
      fill(255,0,0);
      if(!h[i]){
        ellipse((R[i]*cos(angle[i])),(R[i]*sin(angle[i])),sizeE[i],sizeE[i]);
        angle[i]+=0.005;
        enemys[i][0] = R[i]*cos(angle[i]);
        enemys[i][1] = R[i]*sin(angle[i]);
      }
    }
    //println(enemys[0][0],enemys[0][1]);
  }

  boolean enemyHit(float x,float y){
    int flag = 0;
    for(int j = 0;j <100;j++){
      if(dist(x,y,enemys[j][0],enemys[j][1]) <= sizeE[j]/2 && !h[j]){
          preX[preN%100] = x;
          preY[preN%100] = y;
          flag = 1;
      }
    }
    if(flag == 1){
      reset();
      preN++;
      return false;
    }
    return true;
  }
  void preEHit(){
    for(int i = 0;i < 100;i++){
      for(int j = 0;j < 100;j++){
        if(dist(preX[j],preY[j],enemys[i][0],enemys[i][1]) < sizeE[i]/2){
          h[i] = true;
        }
      }
    }
  }
}
