/* memo
  Game_main
    |-Chara
    |-GameFlow
    |-Object
    |-Stage
  現在ステージ番号はゲームフローが記憶(gf.Stage_id)
  死亡数はゲームフローが記憶(gf.deadCnt)
*/
GameFlow  gf = new GameFlow();
Title     ti = new Title();
Stage[]   st = new Stage[4];
Chara     ch = new Chara();

//=================================================================================================//
//key_cotrol//
//==========//
boolean up, down, left, right;
boolean show_htp = false, ask_retry = false, ask_go_title = false;
void keyPressed() {
  char[] st = {'1', '2', '3', '4'};
  if(gf.Title) {
    if(show_htp == false) {
      for(int i = 0; i < 4; i++) {
        if(key == st[i]) {
          gf.move_to_stage_i(i);            //GameFlow:move_to_stage_i      * i_is_stage_number
          ch.init_chara();                  //Chara:init_character
        }
      }
    }
    
    if(key == 'h' || key == 'H') {
      show_htp = true;
    }
    if(show_htp && keyCode == ENTER) {
      show_htp = false;
    }
  }
  
  if(gf.Game == true) {               
    //about_control_character==begin==
    if(keyCode == RIGHT) right = true;      //
    if(keyCode == LEFT)  left = true;       //
    if(keyCode == UP)    up = true;         //
    if(keyCode == DOWN)  down = true;       //
    //about_control_character===end===
    
    if(ch.is_dead() && (key == 'r' || key == 'R')) {
      ask_retry = true;
    }
  }
  
  if((gf.Game == true && ch.is_dead()) || gf.Clear == true) {
    if(key == 't' || key == 'T') {
      ask_go_title = true;
    }
  }
}


void keyReleased() {
  if(gf.Game == true) {               //about_control_character==begin==
    if(keyCode == RIGHT) right = false;     //
    if(keyCode == LEFT)  left = false;      //
    if(keyCode == UP)    up = false;        //
    if(keyCode == DOWN)  down = false;      //
  }
  //about_control_character===end===
}
//=================================================================================================//



//=================================================================================================//
//show_message//
//============//
void showMessage(String mes, int strsize, int strX, int strY) {
  fill(0);
  textSize(strsize);
  text(mes, strX, strY);
}
//=================================================================================================//



//=================================================================================================//
//Game_clear_and_fail_processing//
//====================//
void askRetry() {
  if(ask_retry) {                                                         //retry when 'r' or 'R' is pressed  
    gf.increase_deadCnt();                                                //GameFlow:deadCnt++
    st[gf.Stage_id].inputBrokenCharaStatus(ch.cx, ch.cy, ch.cd);          //Stage:memorize_chara's_broken_point
    st[gf.Stage_id].init_stage();                                         //Stage:init_stage
    ch.init_chara();                                                      //Chara:init_character
    ask_retry = false;
  }
}

void askGoTitle() {
  if(ask_go_title) {                                                      //go title when 't' or 'T' is pressed
    st[gf.Stage_id].reset_broken();                                       //reset broken characters
    st[gf.Stage_id].init_stage();                                         //Stage:init_stage
    ch.init_chara();                                                      //Chara:init_character
    gf.back_title();
    ask_go_title = false;
  }
}

void gameFailed() {
  showMessage("PRESS 'R' TO PLAY AGAIN", 16, width / 2 - 100, height / 2 + 34);
  showMessage("PRESS 'T' TO BACK TO TITLE", 16, width / 2 - 100, height / 2 + 58);
  st[gf.Stage_id].stop_stage();
  ch.playing = false;
  showMessage("You Lose :(", 28, width / 2 - 70, height / 2 - 34);
  askRetry();
  askGoTitle();
}

void gameCleared() {
  background(255, 255, 128);
  showMessage("PRESS 'T' TO BACK TO TITLE", 16, width / 2 - 110, height / 2 + 34);
  ch.playing = false;
  showMessage("Stage Cleared!!!!!", 28, width / 2 - 110, height / 2 - 34);
  askGoTitle();
}

void white_out() {
  st[gf.Stage_id].object_white_out();
  ch.chara_white_out();
}
//=================================================================================================//



void control_character() {
  float step = 3.0;
  if(right == true) ch.move_chara(step, 0);
  if(left == true) ch.move_chara(-step, 0);
  if(up == true) ch.move_chara(0, -step);
  if(down == true) ch.move_chara(0, step);
}

//=================================================================================================//
//collision_detection//
//===================//
void jud_safe(int id) {
  int i;
  float walls[][] = {{width, width + 1.0, 0.0, height},
                       {-1.0, 0.0, 0.0, height},
                       {0.0, width, -1.0, 0.0},
                       {0.0, width, height, height + 1.0}};
  
  //collision_detection_WALLs
  for(i = 0; i < 4; i++) {
    if(ch.chara_is_in_window(walls[i]) == false) {
      ch.damage();
      if(ch.is_dead()) {
        break;
      }
    }
  }

  //collision_detection_ELLIPSEs
  for(i = 0; i < st[id].o.elps_num; i++) {
    if(ch.ifsafe_elps(st[id].o.call_elps_status(i)) == false) {
      ch.damage();
      if(ch.is_dead()) {
        break;
      }
    }
  }
 
  //collision_detection_RECTANGLEs
  for(i = 0; i < st[id].o.rect_num; i++) {
    if(ch.ifsafe_rect(st[id].o.call_rect_status(i)) == false) {
      ch.damage();
      if(ch.is_dead()) {
        break;
      }
    }
  }

  //collision_detection_BROKEN_CHARAs
  for(i = 0; i < gf.getDeadCount(); i++) {
    if(ch.ifsafe_elps(st[id].callBrokenCharaStatus(i)) == false) {
      ch.damage();
      if(ch.is_dead()) {
        break;
      }
    }
  }
 
}
//=================================================================================================//

void setup() {
  size(600, 400);//
  st[0] = new Stage1();
  st[1] = new Stage2();
  st[2] = new Stage3();
  st[3] = new Stage4();
  ch.init_chara();
  for(int i = 0; i < 4; i++) {
    st[i].init_stage();
    st[i].set_obj();           //Stage:set_objects
  }
}
int num = 0;
void draw() {
  if(gf.Title) {                       //state:title
    ti.display_title();                //Title:display_title
    if(show_htp == true) {             
      ti.display_how_to_play();        //Title:display_how_to_play
    }
  } else if(gf.Game) {                     //state:game
    st[gf.Stage_id].showBg();              //Stage:draw_stage_background
    st[gf.Stage_id].display();
    control_character();
    ch.draw_chara();                       //Chara:draw_character
    st[gf.Stage_id].drawBrokenChara();     //Stage:draw_broken_character
    //println(st[gf.Stage_id].o.rect_num);
    if(ch.is_dead()) {                     //(hp < 0)
      white_out();                         //white out
      gameFailed();                        //print_message_"you lose" and ask_continue
    } else {
      jud_safe(gf.Stage_id);               //collision_detection
      
    }
    if(st[gf.Stage_id].ifClear()) {       //Stage:when reach the goal
      gf.stageClear();
    }
  } else if(gf.Clear) { 
    gameCleared();                         //print_message_"game cleared" and ask_continue
  }
}
