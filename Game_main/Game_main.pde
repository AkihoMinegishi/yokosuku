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
  if(ask_retry) {                                                                  //retry when 'r' or 'R' is pressed
    float[] around_first_pos = {width / 8, height / 2, ch.cd * 2.5, ch.cd * 2.5};  //avoid respawn-kill
    if(ch.ifsafe_elps(around_first_pos)) {                                        
      gf.increase_deadCnt();                                                       //GameFlow:deadCnt++
      st[gf.Stage_id].inputBrokenCharaStatus(ch.cx, ch.cy, ch.cd);                 //Stage:memorize_chara's_broken_point
    }
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
  if(gf.Stage_id > 0) {
    st[gf.Stage_id].object_white_out();
    ch.chara_white_out();
  }
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

//whethere reach the goal or not
boolean ifGoal(int id) {
  if(ch.ifsafe_rect(st[id].o.call_goal_status()) == false) {
    return true;
  } else {
    return false;
  }
}

//====================================================================
//  stage3  //
//==========//
////////////////////stage3///////////////////////////
float deg,deg2 = 0;
PImage img,img2;
Enemy e;
PrePlayer p;
Stage3_draw s3;
Title t;

float xP,yP;
float time= 0;
float mx = 0;
float my = 0;
//////////////////////////////////////////////////////
//====================================================================


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
  if(gf.Title) {                       //state:title
    ti.display_title();                //Title:display_title
    if(show_htp == true) {             
      ti.display_how_to_play();        //Title:display_how_to_play
    }
  } else if(gf.Game) {                     //state:game
  
    /////////////////////////////////////////////////////////////////////////////////////////////////
    if(gf.Stage_id == 2) {
      //title画面から3を選ぶと////
      changeWindowSize(600, 700);
      println(time);
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
      if(time > 2300){
        textSize(100);
        text("Clear!",500,0);
        text("RETRY:",500,100);
        text(preN,500,200);
        noLoop();
      }
      popMatrix();
    } else {///////////////////////////////////////////////////////////////////////////////////////     
      
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
      if(ifGoal(gf.Stage_id)) {       //Stage:when reach the goal
        gf.stageClear();
      }
    }
    
  } else if(gf.Clear) { 
    gameCleared();                         //print_message_"game cleared" and ask_continue
  }
  
}
