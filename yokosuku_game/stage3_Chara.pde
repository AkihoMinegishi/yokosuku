class PrePlayer{
  float xP = 10,yP = 400;
  float degP = 0;
  void drawMe(){
    pushMatrix();
    //translate(-0,-0);
    rotate(degP*PI/180);
    fill(255);
    ellipse(xP,yP,10,10);
    xP--;
    yP+=0.5;
    popMatrix();
  }
  
  void move(){
    if(right)xP+=3;
    if(left)xP-=3;
    if(up)yP-=3;
    if(down)yP+=3;
  }
  
}
