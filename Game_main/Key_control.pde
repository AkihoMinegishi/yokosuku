//=================================================================================================//
//key_cotrol//
//==========//
boolean up, down, left, right, change_style;
boolean show_htp = false, ask_retry = false, ask_go_title = false;

void keyPressed() {
  
  char[] st = {'1', '2', '3', '4'};
  if(gf.Title) {
    if(show_htp == false) {
      //move to the N stage
      for(int i = 0; i < 4; i++) {
        if(key == st[i]) {
          up = down = left = right = false;
          gf.move_to_stage_i(i);            //GameFlow:move_to_stage_i      * i_is_stage_number
          ch.init_chara();                  //Chara:init_character
        }
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
      if(show_htp && keyCode == ENTER) {
        show_htp = false;
      }
    } 
  }
  
  if(gf.Game) {           
    //about_control_character==begin==
    if(ti.key_config == 0) {
      if(keyCode == RIGHT) right = true;   //move to right
      if(keyCode == LEFT)  left  = true;   //move to left
      if(keyCode == UP)    up    = true;   //move to up
      if(keyCode == DOWN)  down  = true;   //move to down
      if(keyCode == 'r')reset();
      if(keyCode == 't')gf.back_title();
      
    } else {
      if(key == 'd') right = true;   //move to right
      if(key == 'a')  left = true;   //move to left
      if(key == 'w')    up = true;   //move to up
      if(key == 's')  down = true;   //move to down
    }
    //about_control_character===end===
    if(ch.is_dead() && (key == 'r' || key == 'R')) {
      ask_retry = true;
    }
  }
  
  if((gf.Game && ch.is_dead()) || gf.Clear) {
    if(key == 't' || key == 'T') {
      ask_go_title = true;
    }
  }
  
}


void keyReleased() {
  
  if(gf.Title) {
    if(change_style) {
      if(keyCode == SHIFT) {
        ti.key_config = (ti.key_config+1) % 2;
        change_style = false;
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
