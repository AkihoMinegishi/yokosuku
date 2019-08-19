//=================================================================================================//
//key_cotrol//
//==========//
boolean up, down, left, right, change_style;
boolean show_htp = false, ask_retry = false, ask_go_title = false;
boolean ifstop_chara = true; //for stage4
int knmcmd_step;

void keyPressed() {
  
  char[] st = {'1', '2', '3', '4'};
  if(gf.Title) {
    if(show_htp == false) {
      knmcmd_step = 0;
      //move to the N stage
      for(int i = 0; i < 4; i++) {
        if(key == st[i]) {
          up = down = left = right = false;
          gf.move_to_stage_i(i);            //GameFlow:move_to_stage_i      * i_is_stage_number
          ch.init_chara(ti.knm_command);    //Chara:init_character
        }
      }
      if(ti.unlock_5th && key == '5') {
        up = down = left = right = false;
        gf.move_to_stage_i(4);
        ch.init_chara(ti.knm_command);
      }
      //show how to play
      if(keyCode == ENTER) {
        show_htp = true;
      }
    } else {
      //change key style
      if(keyCode == SHIFT) {
        change_style = true;
      }
      //back to the title
      if(keyCode == ENTER) {
        show_htp = false;
      }
      
    }
    
    if(key == 's' || key == 'S') {
      gf.move_to_save_screen();
    }
    if(!sv.ifnew_file && sv.ifask_load_file) {
      if(key == 'y' || key == 'Y') {
        if(sv.ifright_file) {
          load_file();
          sv.ifask_load_file = false;
        } else {
          tm.measure_start();
          sv.ifshow_penalty = true;
        }
      }
      if(key == 'n' || key == 'N') {
        sv.reset_file();
        sv.ifask_load_file = false;
      }
    }
  }
  
  if(gf.Saves) {
    if(key == 'y' || key == 'Y') {
      sv.write_file(gf.totalDeadCnt, 
                 ti.knm_command, ti.show_unlocking, ti.unlock_5th, ti.thx4play, ti.if_clear_marks);
      load_file();
      
      gf.back_title();
    }
    if(key == 'n' || key == 'N') {
      gf.back_title();
    }
  }
  
  if((gf.Title && show_htp) || (gf.Game && ti.key_config == 0)) {
    if(keyCode == RIGHT) right = true;   //move to right
    if(keyCode == LEFT)  left  = true;   //move to left
    if(keyCode == UP)    up    = true;   //move to up
    if(keyCode == DOWN)  down  = true;   //move to down
  }
  
  if(gf.Game) {           
    //about_control_character==begin==
    if(ti.key_config == 1) {
      if(key == 'd') right = true;   //move to right
      if(key == 'a')  left = true;   //move to left
      if(key == 'w')    up = true;   //move to up
      if(key == 's')  down = true;   //move to down
    }
    //about_control_character===end===
    if(ch.is_dead() && (key == 'r' || key == 'R')) {
      ask_retry = true;
    }
    
    //abouut stage4's trap
    if(gf.Stage_id == 3) {
      if(tm.jud_time_between(1, 9000)) {
        if(key == 'Z') {
          ifstop_chara = false;
        }
      }
    }
    
  }
  
  if((gf.Stage_id != 2 && (gf.Game && ch.is_dead())) || (gf.Stage_id == 2 && gf.Game && ifIndicate_back_title) || gf.Clear) {
    if(key == 't' || key == 'T') {
      ask_go_title = true;
    }
  }
  
}


void keyReleased() {
  
  if(gf.Title) {
    if(show_htp) {
      if(change_style) {
        if(keyCode == SHIFT) {
          ti.key_config = (ti.key_config+1) % 2;
          change_style = false;
        }
      }
      
      //573 command
      jud_knm_command(knmcmd_step);
      if(knmcmd_step == 10) {
        if(ti.knm_command) {
          ti.knm_command = false;
        } else {
          ti.knm_command = true;
        }
        knmcmd_step = 0;
      }
    }
  }
  
  if(gf.Game) {
    //about_control_character==begin==
    if(ti.key_config == 0) {
      if(keyCode == RIGHT) right = false;   //move to right
      if(keyCode == LEFT)  left  = false;   //move to left
      if(keyCode == UP)    up    = false;   //move to up
      if(keyCode == DOWN)  down  = false;   //move to down
    } else {
      if(key == 'd') right = false;   //move to right
      if(key == 'a')  left = false;   //move to left
      if(key == 'w')    up = false;   //move to up
      if(key == 's')  down = false;   //move to down
    }
    //about_control_character===end===
  }
  
}
//=================================================================================================//

void control_character() {
  if(right == true) ch.move_chara(ch.steps, 0);
  if(left  == true) ch.move_chara(-ch.steps, 0);
  if(up    == true) ch.move_chara(0, -ch.steps);
  if(down  == true) ch.move_chara(0, ch.steps);
}

void jud_knm_command(int st) {
  if(((st <= 1) && keyCode == UP) || ((st == 2 || st == 3) && keyCode == DOWN) || 
     ((st == 4 || st == 6) && keyCode == LEFT) || ((st == 5 || st == 7) && keyCode == RIGHT) ||
     (st == 8 && (key == 'b' || key == 'B')) || (st == 9 && (key == 'a' || key == 'A'))) {
       knmcmd_step++;
  }
}
