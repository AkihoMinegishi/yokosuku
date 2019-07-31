/*
methods::
 init:set_flags
 move_to_stage_i:move_to_stage_i          * i_is_stage_number
 dead:deadCnt++
 getDeadCount:get_deadCnt
 allClear:when_clear(no_if)
*/
class GameFlow {
  boolean Title, Game, Clear, ifSumDeadCnt; //judge statement
  int Stage_id = 0; //stage number
  int deadCnt = 0; //counting death(reseted by moving stage)
  int[] totalDeadCnt = {0, 0, 0, 0, 0};
  
  GameFlow() {
    Title = true;
    Game  = false;
    Clear = false;
  }

  //reset die count and warp stage
  void move_to_stage_i(int i) {
    /*for(int id = 0; id < 5; id++) {
      print(totalDeadCnt[id] + " ");
    }
    println();*/
    
    Stage_id = i;
    //init
    deadCnt = 0;
    ifSumDeadCnt = true;
    Game = true;
    Title = Clear = false;
  }

  //+1 die count
  void increase_deadCnt() {
    deadCnt++;
  } 

  //get die count
  int getDeadCount() {
    return deadCnt;
  }

  //move to the end of the game
  void stageClear() {
    Clear = true;
    Title = Game = false;
  }
  
  //back to the title
  void back_title() {
    if(ifSumDeadCnt) {
      if(Stage_id != 2) {
        totalDeadCnt[Stage_id] += deadCnt;
      } else {
        totalDeadCnt[Stage_id] += preN;
      }
      ifSumDeadCnt = false;
    }
    Stage_id = 0;
    Title = true;
    Game = Clear = false;
  }
}