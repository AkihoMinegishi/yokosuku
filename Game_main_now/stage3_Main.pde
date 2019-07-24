//done

void reset(){
  mx = 0;my= 0;
  time = 0;
  xP = 10;
  yP = 600;
}

float[] preX = new float[100];
float[] preY = new float[100];
int preN = 0;

void hit(boolean x){
  if(!x){
    noLoop();
    if(key=='r'){
      reset();
      //loop();
    }
  }
}

void changeWindowSize(int w, int h) {
  frame.setSize( w + frame.getInsets().left + frame.getInsets().right, h + frame.getInsets().top + frame.getInsets().bottom );
  size(w, h);
}
