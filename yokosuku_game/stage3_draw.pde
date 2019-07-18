class Stage3_draw{
  void drawStage(float mx,float my){
    translate(mx,my);
    fill(119,188,240);
    ellipse(0,0,1600,1600);
    fill(200);
    ellipse(0,-0,1000,1000);
    drawGear(); 
  }
}


boolean stageHit(float x,float y){
  if(dist(x,y,0,0) > 500 && dist(x,y,0,0) < 800){
    return true;
  }
  preX[preN%100] = x;
  preY[preN%100] = y;
  return false;
}
void drawGear(){
  rectMode(CENTER);
  pushMatrix();
  rotate(deg*PI/180);
  //image(img2,(-img2.width/2),(-img2.height/2));
  rotate(deg2*PI/180);
  //image(img,(-img.width/2),(-img.height/2));
  deg += 0.1;
  deg2 -= 1;
  popMatrix();
}
