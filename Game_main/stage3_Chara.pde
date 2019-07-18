//done

class PrePlayer{                  //broken
  float degP = 0;
  void drawMe(){
    pushMatrix();
    fill(255);
    ellipse(xP,yP,10,10);
    popMatrix();
  }
  
  void move(){                    //move
    if(right)xP+=5;
    if(left)xP-=5;
    if(up)yP-=5;
    if(down)yP+=5;
  }
  void preMe(){                   //broken
    fill(128);
    for(int i = 0;i <100;i++){
      fill(128);
      ellipse(preX[i],preY[i],10,10);
      hit(preMHit(xP,yP));
    }
  }
   boolean preMHit(float x,float y){      //collision_detection
    int flag = 0;
    for(int j = 0;j <100;j++){
      if(dist(x,y,preX[j],preY[j]) <= 10){
       if(preX[j]!=10 && preY[j] != 600){ 
          preX[preN%100] = x;
          preY[preN%100] = y;
          flag = 1;
       }
      }
    }
    if(flag == 1){
      reset();
      return false;
    }
    return true;
  }
  
}
