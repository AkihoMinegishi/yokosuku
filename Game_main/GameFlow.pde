class GameFlow {
  boolean nowTitle, nowGame, nowClear, pressedEnter; //judge statement
  int nowStage = 0; //stage number
  int diecnt = 0; //counting death(reseted by moving stage)
  
  GameFlow() {
    nowTitle = true;
    nowGame = nowClear = false;
  }
  
  //reset die count and warp stage
  void warpStage(int dir) {
    nowStage = dir;
    diecnt = 0;
    nowGame = true;
    nowTitle = nowClear = false;
  }
  
  //+1 die count
  void dead() {
    diecnt++;
  }
  
  //get die count
  int deadCount() {
    return diecnt;
  }
  
  //move to the end of the game
  void allClear() {
    nowClear = true;
    nowTitle = nowGame = false;
  }
}
