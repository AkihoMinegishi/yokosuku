/**memo*************************************************
  <構成>===========
  Game_main
    |-Title
    |-Chara
    |-GameFlow
    |-Stage
        |-Object
  ================
  
  現在ステージ番号はゲームフローが記憶(gf.Stage_id)
  死亡数はゲームフローが記憶(gf.deadCnt)
********************************************************/
GameFlow  gf = new GameFlow();
Title     ti = new Title();
Stage[]   st = new Stage[4];
Chara     ch = new Chara();

//=================================================================================================//
//key_cotrol//
//==========//
void keyPressed() {
  char[] st = {'1', '2', '3', '4'};
  if(gf.Title) {
    for(int i = 0; i < 4; i++) {
      if(key == st[i]) {
        gf.move_to_stage_i(i);            //GameFlow:move_to_stage_i      * i_is_stage_number
        ch.init_chara();                  //Chara:init_character
      }
    }
  }

  if(gf.Game) {                           //control_character==begin==
    float step = 7.0;                       //
    if(keyCode == RIGHT) {                  //
      ch.move_chara(step, 0);               //
    }                                       //
    if(keyCode == LEFT) {                   //
      ch.move_chara(-step, 0);              //
    }                                       //
    if(keyCode == UP) {                     //
      ch.move_chara(0, -step);              //
    }                                       //
    if(keyCode == DOWN) {                   //
      ch.move_chara(0, step);               //
    }                                       //
  }                                       //control_character===end===
}


void keyReleased() {

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
//Game_fail_processing//
//====================//
void askContinue() {
  showMessage("PRESS 'R' TO PLAY AGAIN", 16, width / 2, height / 2 + 24);
  if(keyPressed && (key == 'r' || key == 'R')) {
    gf.increase_deadCnt();                                                //GameFlow:deadCnt++
    st[gf.Stage_id].inputBrokenCharaStatus(ch.cx, ch.cy, ch.cd);          //Stage:memorize_chara's_broken_point
    ch.init_chara();                                                      //Chara:init_character
  }
}

void gameFailed() {
  ch.playing = false;
  showMessage("You Lose :(", 28, width / 2, height / 2);
  askContinue();
}
//=================================================================================================//



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
  
  //collision_detection_BROKENs***********************************************************************************************************
  
 
}
//=================================================================================================//

void setup() {
  size(600, 400);  
  st[0] = new Stage1();
  st[1] = new Stage2();
  st[2] = new Stage3();
  st[3] = new Stage4();
  ch.init_chara();
  for(int i = 0; i < 4; i++) {
      st[i].set_obj();           //Stage:set_objects
  }
}

void draw() {
  if(gf.Title) {                       //state:title
    ti.display_title();                    //Title:display_title    
  } else if(gf.Game) {                 //state:game
    st[gf.Stage_id].showBg();              //Stage:draw_stage_background
    st[gf.Stage_id].display();
    ch.draw_chara();                       //Chara:draw_character
    st[gf.Stage_id].drawBrokenChara();     //Stage:draw_broken_character
    if(ch.is_dead()) {                  //(hp < 0)
      gameFailed();                       //print_message_"you lose" and ask_continue
    } else {
      jud_safe(gf.Stage_id);              //collision_detection
      
    }
  } else if(gf.Clear) { 
                                          //*under construction*
  }
}
