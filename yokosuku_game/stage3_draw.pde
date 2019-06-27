class Stage3{
  void drawStage(int mx,int my){
    translate(mx,my);
    fill(119,188,240);
    ellipse(0,0,1600,1600);
    fill(200);
    e.drawE(10);
    ellipse(0,-0,1000,1000);
    drawGear(mx,my); 
  }
}
