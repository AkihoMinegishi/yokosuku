/*
methods::
 init:set_flags
 move_to_stage_i:move_to_stage_i          * i_is_stage_number
 dead:deadCnt++
 getDeadCount:get_deadCnt
 allClear:when_clear(no_if)
*/
class GameFlow {
  boolean Title, Game, Clear, pressedEnter; //judge statement
  int Stage_id = 1; //stage number
  int deadCnt = 0; //counting death(reseted by moving stage)

  GameFlow() {
    Title = true;
    Game  = false;
    Clear = false;
  }

  //reset die count and warp stage
  void move_to_stage_i(int i) {
    Stage_id = i;
    //init
    deadCnt = 0;
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
    Title = true;
    Game = Clear = false;
  }
}
