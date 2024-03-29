/* memo
  Game_main
    |-Chara
    |-GameFlow
    |-Object
    |-Stage
    |-Time
    |-Title
  現在ステージ番号はゲームフローが記憶(gf.Stage_id)
  死亡数はゲームフローが記憶(gf.deadCnt)
*/
GameFlow  gf = new GameFlow();
Title     ti = new Title();
Stage[]   st = new Stage[5];
Chara     ch = new Chara();
Time      tm = new Time();
Saves     sv = new Saves();


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
  if(ask_retry) {                                                                  //retry when 'r' or 'R' is pressed
    float[] around_first_pos = {width / 8, height / 2, ch.cd * 2.5, ch.cd * 2.5};  //avoid respawn-kill
    if(ch.ifsafe_elps(around_first_pos)) {                                        
      st[gf.Stage_id].inputBrokenCharaStatus(ch.cx, ch.cy, ch.cd);                 //Stage:memorize_chara's_broken_point
    }
    gf.increase_deadCnt();                                                       //GameFlow:deadCnt++
    st[gf.Stage_id].init_stage();                                         //Stage:init_stage
    st[gf.Stage_id].init_stage_for_each();
    ch.init_chara(ti.knm_command);                                        //Chara:init_character
    tm.init_time();                                                       //Time:init_time
    ask_retry = false;
  }
}

void askGoTitle() {
  if(ask_go_title) {                  //go to the title when 't' or 'T' is pressed
    if(ch.is_dead()) {
      gf.increase_deadCnt();
    }
    st[gf.Stage_id].reset_broken();         //reset broken characters
    st[gf.Stage_id].init_stage();           //Stage:init_stage
    st[gf.Stage_id].init_stage_for_each();
    ch.init_chara(ti.knm_command);          //Chara:init_character
    tm.init_time();                         //Time:init_time
    gf.back_title();                        //GameFlow:calc total death and go title 
    if(width != 600 || height != 400) {
      changeWindowSize(600, 400);
    }
    ask_go_title = false;
  }
}

void gameFailed() {
  showMessage("PRESS [R] TO PLAY AGAIN", 16, width / 2 - 100, height / 2 + 34);
  showMessage("PRESS [T] TO BACK TO THE TITLE", 16, width / 2 - 125, height / 2 + 58);
  st[gf.Stage_id].stop_stage();
  ch.playing = false;
  showMessage("You Lose :(", 28, width / 2 - 70, height / 2 - 34);
  askRetry();
  askGoTitle();
}

void fill_aleart(int cnt) {
  int len = 1500, rCol, gCol, bCol;
  if(cnt == 4) {
    int tm_per = tm.get_passed_time() % len;
    if(tm_per >= len / 2) tm_per = len - tm_per;
    rCol = int(255 * (tm_per * 1.0 / (len / 2)));
    gCol = int(255 * (tm_per * 1.0 / (len / 2)));
    bCol = int(128 * (tm_per * 1.0 / (len / 2)));
    fill(rCol, gCol, bCol);
  }
}

void gameCleared() {
  if(gf.Stage_id <= 3) {
    background(255, 255, 128);
  } else {
    background(255, 64, 64);
    ti.thx4play = true;
  }
  ti.if_clear_marks[gf.Stage_id] = true;
  fill(0);
  fill_aleart(ti.cnt_clear_marks());
  textSize(16);
  text("PRESS [T] TO BACK TO THE TITLE", width / 2 - 132, height / 2 + 50);
  showMessage("Stage Cleared!!!", 28, width / 2 - 105, height / 2 - 50);
  if(gf.Stage_id == 2 && preN > 0) {
    showMessage("Retry Count: " + preN, 20, width / 2 - 70, height / 2 - 12);
  } else if(gf.deadCnt == 0){
    showMessage("Marvelous!!!!!", 28, width / 2 - 87, height / 2 - 12);
  }
  ch.playing = false;
  askGoTitle();
}

void white_out() {
  if(gf.Stage_id > 0) {
    st[gf.Stage_id].object_white_out(0);
    ch.chara_white_out(0);
  }
}
//=================================================================================================//


//=================================================================================================//
//Traps_on_stages//
//====================//

//Stage4
void make_sayo_nara_event() {
  if(ch.is_dead()) {
    tm.stop_time();
  }
  
  st[3].get_time(tm.get_passed_time());
  if(-st[3].x_pos < 200.0) {
    ch.change_chara_steps(2.0);
    tm.measure_start();
    ifstop_chara = true;
  }
  
  if(tm.jud_time_between(1, 9000)) {
    ch.chara_white_out(1);
  } else if(ch.is_dead() == false) {
    ch.chara_get_color();
  }
  
  if(ifstop_chara && tm.jud_time_between(1, 9000)) {
    ch.change_chara_steps(0.0);
  }
  if(ifstop_chara == false && tm.jud_time_between(1, 9000) && ch.is_dead() == false) {
    ch.change_chara_steps(3.0);
    ch.chara_get_color();
  }
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
    if(st[id].o.obelps[i][4] == 1) {
      if(ch.ifsafe_elps(st[id].o.call_elps_status(i)) == false) {
        ch.damage();
        if(ch.is_dead()) {
          break;
        }
      }
    }
  }
 
  //collision_detection_RECTANGLEs
  for(i = 0; i < st[id].o.rect_num; i++) {
    if(st[id].o.obrect[i][4] == 1) {
      if(ch.ifsafe_rect(st[id].o.call_rect_status(i)) == false) {
        ch.damage();
        if(ch.is_dead()) {
          break;
        }
      }
    }
  }
  //collision_detection_RECTANGLE_on_Stage4
  if(id == 3) {
    if(ch.ifsafe_rect(st[id].txtrect_status()) == false) {
      ch.damage();
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

//whethere reach the goal or not
boolean ifGoal(int id) {
  for(int i = 0; i < st[id].o.goal_num; i++) {
    if(st[id].o.obgoal[i][4] == 1) {
      if(ch.ifsafe_rect(st[id].o.call_goal_status(i)) == false) {
        return true;
      }
    }
  }
  return false;
}

//=================================================================================================//
//about saving//
//===================//
void load_file() {
  gf.set_deadCnt(sv.load_dc());
  ti.set_bolSet(sv.load_set());
  ti.set_clMks(sv.load_mks());
}

//====================================================================
//  stage3  //
//==========//
////////////////////stage3///////////////////////////
/*float deg,deg2 = 0;
PImage img,img2;
Enemy e;
PrePlayer p;
Stage3_draw s3;
Title t;

float xP,yP;
float time= 0;
float mx = 0;
float my = 0;*/
//////////////////////////////////////////////////////
//====================================================================


void setup() {
  size(600, 400);
  st[0] = new Stage1();
  st[1] = new Stage2();
  st[2] = new Stage3();
  st[3] = new Stage4();
  st[4] = new Stage5();
  ch.init_chara(ti.knm_command);
  tm.init_time();
  for(int i = 0; i < 5; i++) {
    st[i].init_stage();
    st[i].init_stage_for_each();
    st[i].set_obj();           //Stage:set_objects
  }
  sv.get_file();
  sv.check_new_file();
  if(!sv.ifnew_file) {
    sv.check_right_file();
  }
  
  ///////////////////stage3////////////////////////////
  xP = 10;
  yP = 600;
  time = 0;
  p = new PrePlayer();
  e = new Enemy();
  s3 = new Stage3_draw();
  e.setE(100);
  //img = loadImage("2970.png");
  //img2 = loadImage("2970.png");
  //img.resize(img.width/5,img.height/5);
  //img2.resize(img2.width/3,img2.height/3);
  frameRate(60);
  ///////////////////////////////////////////////////////
}

void draw() {
  tm.measure_whole_time();
  if(gf.Title) {                       //state:title
    ti.display_title();                //Title:display_title
    if(show_htp == true) {             
      ti.display_how_to_play();        //Title:display_how_to_play
    }
    if(!sv.ifnew_file && sv.ifask_load_file) {
      sv.ask_load_file();
    }
  } else if(gf.Saves) {
    sv.show_save_screen();
  } else if(gf.Game) {                     //state:game
  
    /////////////////////////////////////////////////////////////////////////////////////////////////
    if(gf.Stage_id == 2) {
      background(200);
      //title画面から3を選ぶと////
      changeWindowSize(600, 700);
      //println(time);
      time++;
      if(time%4000 > 100 && time%2000 < 450){
        mx-=0.5;my+=1.0;
      }else if(time%2200 > 600 && time%2200 < 1000){
        mx+=1;
      }else if(time%2200 > 1100 && time%2200 < 1500){
        mx+=0.5;my-=0.5;
      }else if(time%2000 > 1550 && time%2200 < 1950){
        mx-=1;my-=0.5;
      }else if(time%2200 > 2000 && time%2200 < 2199){
      }
      translate(mx,my);
      fill(200);
      s3.drawStage(mx,my);
      p.drawMe();
      p.move();
      p.preMe();
      e.drawE(100);
      hit(e.enemyHit(xP,yP));
      hit(stageHit(xP,yP));
      e.preEHit();
      hit(p.preMHit(xP,yP));
      println(preN);
      pushMatrix();
      fill(0,0,255);
      textSize(100);
      text(time,-100,0);
      if(time > 2300) {
        textSize(100);
        text("Clear!",500,0);
        text("RETRY:",500,100);
        text(preN,500,200);
        gf.stageClear();
      }
      popMatrix();
      ask_back_title_st3(preN);
    } else {///////////////////////////////////////////////////////////////////////////////////////     
      
      st[gf.Stage_id].showBg();              //Stage:draw_stage_background
      st[gf.Stage_id].events();              //Stage:changing_scroll etc...
      if(gf.Stage_id == 3) {
        make_sayo_nara_event();
      }
      st[gf.Stage_id].display();             //Stage:show_objects
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
      if(ifGoal(gf.Stage_id)) {       //Stage:when reach the goal
        gf.stageClear();
      }
    }
    
  } else if(gf.Clear) { 
    gameCleared();                         //print_message_"game cleared" and ask_continue
  }
  
}
