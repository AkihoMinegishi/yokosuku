import java.io.File;
import java.io.PrintWriter;

class Stage4 extends Stage {
  float fall_y;
  boolean chara_white, chara_stop;
  color nor = color(240, 240, 255);
  boolean create_file;
  File fl;
  PrintWriter pw;
  
  void init_stage_for_each() {    
    fall_y = 0.0;
    chara_white = false;
    chara_stop = false;    
    create_file = true;
    //fl = new File("traceback.txt"); //I couldn't make this process :-( 
    //fl.delete();
  }
  
  void showBg() {
    background(nor);
  }
  
  float[] txtrect_status() {
    float[] rc = {20, 25+fall_y, 285, 75};
    return rc;
  }
  void print_traceback() {
    String mes1 = "Oh jeez...There isn't anything wrong, is there? Wait a minute...Hej, you can probably fix this.";
    String mes2 = "Push key 'Z' to make the whole thing right. Why don't you do it right now before when EVERYTHING IS TOO LATE?";
    
    pw.println("I'm sorry, but an uncaught exception occurred.");
    pw.println("");
    pw.println("While running game code:");
    pw.println("File \"Game_main/Chara.pde\", line 31, in draw_chara");
    pw.println("File \"Game_main/Game_main.pde\", line 303, in main");
    pw.println("File \"Game_main/Stage4.pde\", line 78, in events");
    pw.println("processing.draw(\"Game_main\")");
    pw.println("");
    pw.print("JumpException: ");
    pw.println(mes1);
    pw.println(mes2);
    pw.println("");
    pw.println("-- Full Traceback ------------------------------------------------------------");
    pw.println("");
    pw.println("Full traceback:");
    pw.println("File \"Game_main/Chara.pde\", line 31, in draw_chara");
    pw.println("File \"Game_main/Game_main.pde\", line 303, in main");
    pw.println("File \"C:\\Program Files (x86)\\processing\\codes\\Game_main\\Game_main.pde\", line 303, in main");
    pw.println("processing.java.bin(\"java.dll\")");
    pw.println("File \"C:\\Program Files (x86)\\processing\\codes\\Game_main\\Chara.pde\", line 98, in move_chara");
    pw.println("exec bytecode in globals, locals");
    pw.println("File \"Game_main/Stage4.pde\", line 78, in events");
    pw.println("processing.draw(\"Game_main\")");
    pw.println("File \"C:\\Program Files (x86)\\processing\\codes\\Game_main\\Game_main.pde\", line 300, in sayo_nara_event");
    pw.println("raise processing.java.JumpException(ch.args[0])");
    pw.println("");
    pw.print("JumpException: ");
    pw.println(mes1);
    pw.println(mes2);
  } //these message are nonsense lol (this gimmick is inspired by "Doki Doki Literature Club!")
  
  void sayo_nara_event() {
    change_scroll_direction_and_speed(200, 0.0, 2.0, 0.0, 0, 0);
    object_white_out(1);
    background(255);
    noFill();
    noStroke();
    rect(20, 25+fall_y, 285, 75);
    stroke(0);
    fill(0);
    if(create_file) {
      pw = createWriter("traceback.txt");
      print_traceback();
      pw.flush();
      pw.close();
      create_file = false;
    }
    textSize(22);
    text("An exception has occured.", 20, 42+fall_y);
    textSize(15);
    text("File\"Game_main/Stage4.pde\", line 83", 20, 75+fall_y);
    text("See traceback.txt for details.", 20, 100+fall_y);
    noFill();
    if(chara_is_alive) {
      if(8000 <= passed_time && passed_time <= 15000) {
        fall_y += 10;
      }
      if(9000 <= passed_time) {
        object_get_color();
        x_pos = -(200 + 2.0);
      }
    }
  }
  
  
  
  void events() {
  //change_scroll_direction_and_speed(x_pt, y_pt, new_dx, new_dy, x_dir, y_dir);
    change_scroll_direction_and_speed(0.0,  0.0,  2.0,    0.0,    -1,    0);
    if(200.0 <= -x_pos && -x_pos < 202.0) {
      sayo_nara_event();
    }
    change_scroll_direction_and_speed(width / 3 + 2.0,  0.0,  2.0,    0.0,    -1,    0);
    change_scroll_direction_and_speed(1450.0, 0.0,   2.5, 0.0,   1,  0);
    change_scroll_direction_and_speed(1142.5, 0.0,   2.5, 1.0,   0, -1);
    change_scroll_direction_and_speed(1142.5, 40.0,  3.0, 1.0,  -1, -1);
    change_scroll_direction_and_speed(1802.5, 260.0, 2.5, 0.0,   1,  0);
    change_scroll_direction_and_speed(1400.0, 260.0, 0.0, 0.5,   0, -1);
    change_scroll_direction_and_speed(1400.0, 320.0, 0.0, 20.0,  0, -1);
    change_scroll_direction_and_speed(1400.0, 1600.0, 0.0, 0.5,  0, -1);
    change_scroll_direction_and_speed(1400.0, 1900.0, 0.0, 10.0,   0, -1);
    change_scroll_direction_and_speed(1400.0, 2100.0, 15.0, 0.0,  -1, 0);
  }
  
  void set_obj() {
    o.rect_num = o.elps_num = o.goal_num = 0;
    
    o.set_rect(520, 0, 400, height / 5 * 2, 1); //id 0
    o.set_rect(520, height - height / 5 * 2, 400, height / 5 * 2, 1); //id 1
    
    o.set_rect(1020, 50,  100, 300, 1); //id 2~4
    o.set_rect(1200, 0,   100, 150, 1);
    o.set_rect(1200, 250, 100, 150, 1);
    
    o.set_elps(1575, height / 2, 150, 150, 1); //id 0
    for(int i = 0; i < 16; i++) {
      float cenx = 1575, ceny = height / 2;
      o.set_elps(cenx + cos(PI * i / 8) * 175, ceny + sin(PI * i / 8) * 175, 20, 20, 1); //id 1~16
    }
    
    o.set_rect(1900, 600, 1000, 600, 1); //id 5
    o.set_rect(2195, 200, 5, 400, 1); //id 6
    
    for(int i = 0; i < 9; i++) {
      int x0 = 1400, y0 = 1850, dx = 10, dy = 70;
      for(int j = 0; j < 4; j++) {
        o.set_rect(x0+(70*i)+(dx*j), y0+(dy*j), 20, 20, 1);
      }
    }
    
    o.set_rect(1400+width/2-70, 2100+height/2-70, 140, 140, 1);
    
    o.set_rect(3190, 2100, 10, 130, 1);
    o.set_rect(3190, 2370, 10, 130, 1);
    
    //goal
    o.set_goal(2200, 0 + 100, width, height + 200, 1); //id 0
    o.set_goal(3200, 2100, width, height + 200, 1);
  }

}




//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////hidden stage5/////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

class Stage5 extends Stage{  
  void init_stage_for_each() {
    goal_col = color(255, 64, 64);
  }
  
  void showBg() {
    background(255, 255, 128);
  }
  
  //about exist_elps   1           5              10             15             20             25
  int[][] trap_ids = {{1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 1},   //1
                      {1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 1},
                      {1, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 1},
                      {1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 1},
                      {1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 1},   //5
                      {1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 1},
                      {1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 1},
                      {1, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 1},
                      {1, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 0, 0, 0, 1},
                      {1, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 1},   //10
                      {1, 1, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1},
                      {1, 1, 0, 0, 0, 0, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1},
                      {1, 1, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1},
                      {1, 1, 1, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 1, 1},
                      {1, 1, 1, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1}};  //15
  
  
  void otp_soflan(float x1, float y1) {
    change_scroll_direction_and_speed(x1, y1,     0.0, 0.5, 0, -1);
    change_scroll_direction_and_speed(x1, y1+10,  0.0, 2.0, 0, -1);
    change_scroll_direction_and_speed(x1, y1+50,  0.0, 8.0, 0, -1);
    change_scroll_direction_and_speed(x1, y1+450, 0.0, 2.0, 0, -1);
  }
  
  void events() {
  //change_scroll_direction_and_speed(x_pt,    y_pt,    new_dx, new_dy, x_dir, y_dir);
    change_scroll_direction_and_speed(0.0,     0.0,     0.5,    0.0,    -1,    0);
    change_scroll_direction_and_speed(300.0,   0.0,     2.0,    0.0,    -1,    0);
    
    change_scroll_direction_and_speed(2400.0,  0.0,     0.0,    1.0,    0,     -1);
    change_scroll_direction_and_speed(2400.0,  750.0,   0.0,    1.0,    0,     -1);
    if(-x_pos == 2400 && -y_pos == 350) {
      for(int i = 0; i < 15; i++) {
        for(int j = 0; j < 25; j++) {
          o.exist_elps(33+(i*25)+j, trap_ids[i][j]);
        }
      }
    }
    float first_y = 1000.0;
    otp_soflan(2400.0, first_y);
    otp_soflan(2400.0, first_y + 490*1);
    otp_soflan(2400.0, first_y + 490*2);
    otp_soflan(2400.0, first_y + 490*3);
    otp_soflan(2400.0, first_y + 490*4);
    otp_soflan(2400.0, first_y + 490*5);
    otp_soflan(2400.0, first_y + 490*6);
    otp_soflan(2400.0, first_y + 490*7);
    
    change_scroll_direction_and_speed(2400, 5000, 2.0, 0, -1, 0);
    change_scroll_direction_and_speed(3500, 5000, 3.0, 0, -1, 0);
    
    change_scroll_direction_and_speed(5900, 5000, 4.0, 0, -1, 0);
    change_scroll_direction_and_speed(6300, 5000, 6.0, 0, -1, 0);
    change_scroll_direction_and_speed(6900, 5000, 8.0, 0, -1, 0);
    change_scroll_direction_and_speed(7700, 5000, 10.0, 0, -1, 0);
    change_scroll_direction_and_speed(8700, 5000, 14.0, 0, -1, 0);
    change_scroll_direction_and_speed(10100, 5000, 20.0, 0, -1, 0);
    change_scroll_direction_and_speed(12100, 5000, 30.0, 0, -1, 0);
    
    change_scroll_direction_and_speed(13600, 5000, 0.5, 0, -1, 0);
  }
  
  
  
  void set_obj() {
    o.rect_num = o.elps_num = o.goal_num = 0;
    
    o.set_rect(0, 0, 40, height, 1);   //id 0
    o.set_rect(100, 100, 60, 80, 1);
    o.set_rect(140, 180, 20, 80, 1);
    o.set_rect(100, 260, 60, 80, 1);
    o.set_rect(220, 0,   80, 160, 1);
    o.set_rect(220, 240, 80, 160, 1);  //id 5
    
    for(int i = 0; i < 30; i++) {
      o.set_elps(600 + random(width) * 1.5, random(height), 20, 20, 1); //id 0~29
      o.set_rect(600 + random(width) * 1.5, random(height), 20, 20, 1); //id 6~35
    }
    
    o.set_elps(1700, 50,  400, 400, 1);  //id 30
    o.set_elps(2090, 300, 400, 400, 1);
    o.set_elps(2530, 150, 400, 400, 1);  //id 32
    
    int elpsD = 10;
    for(int i = 0; i < 15; i++) {
      for(int j = 0; j < 25; j++) {
        o.set_elps(2457+(j*20), 600+(i*20), elpsD, elpsD, 1);  //[i][j] id 33+(i*25)+j (33~407)
      }
    }
    
    float first_y = 1400.0;
    o.set_rect(2400+50+100*0, first_y,         100, 25, 1);  //id 36
    o.set_rect(2400+50+100*2, first_y,         100, 25, 1);
    o.set_rect(2400+50+100*4, first_y,         100, 25, 1);
    o.set_rect(2400+50+100*1, first_y + 490*1, 100, 25, 1);  //id 39
    o.set_rect(2400+50+100*3, first_y + 490*1, 100, 25, 1);
    o.set_rect(2400+50+100*4, first_y + 490*1, 100, 25, 1);
    o.set_rect(2400+50+100*0, first_y + 490*2, 100, 25, 1);  //id 42
    o.set_rect(2400+50+100*2, first_y + 490*2, 100, 25, 1);
    o.set_rect(2400+50+100*3, first_y + 490*2, 100, 25, 1);
    o.set_rect(2400+50+100*1, first_y + 490*3, 100, 25, 1);  //id 45
    o.set_rect(2400+50+100*2, first_y + 490*3, 100, 25, 1);
    o.set_rect(2400+50+100*4, first_y + 490*3, 100, 25, 1);
    o.set_rect(2400+50+100*0, first_y + 490*4, 100, 25, 1);  //id 48
    o.set_rect(2400+50+100*1, first_y + 490*4, 100, 25, 1);
    o.set_rect(2400+50+100*3, first_y + 490*4, 100, 25, 1);
    o.set_rect(2400+50+100*0, first_y + 490*5, 100, 25, 1);  //id 51
    o.set_rect(2400+50+100*2, first_y + 490*5, 100, 25, 1);
    o.set_rect(2400+50+100*4, first_y + 490*5, 100, 25, 1);
    o.set_rect(2400+50+100*0, first_y + 490*6, 100, 25, 1);  //id 54
    o.set_rect(2400+50+100*1, first_y + 490*6, 100, 25, 1);
    o.set_rect(2400+50+100*2, first_y + 490*6, 100, 25, 1);
    o.set_rect(2400+50+100*3, first_y + 490*6, 100, 25, 1);
    o.set_rect(2400+50+100*0, first_y + 490*7, 100, 25, 1);  //id 57
    o.set_rect(2400+50+100*2, first_y + 490*7, 100, 25, 1);
    o.set_rect(2400+50+100*3, first_y + 490*7, 100, 25, 1);
    o.set_rect(2400+50+100*4, first_y + 490*7, 100, 25, 1);
    
    int rectL = 50;
    for(int i = 0; i < 108; i++) {
      if(rectL*i >= height) {
        o.set_rect(2400, rectL*i, rectL, rectL, 1);
      }
      if(rectL*i < 5000) {
        o.set_rect(3000-rectL, rectL*i, rectL, rectL, 1);
      }
    }
    
    o.set_rect(2950, 5000, 350, 200, 1);
    o.set_rect(3400, 5200, 300, 200, 1);
    
    for(int i = 0; i < 75; i++) {
      o.set_elps(3700 + random(2400), 5000 + random(height), 10, 10, 1);
      o.set_rect(3700 + random(2400), 5000 + random(height), 10, 10, 1);
    }
    
    for(int i = 0; i < 150; i++) {
      o.set_elps(6100 + i * 50, 5000 + i, 10, 10, 1);
      o.set_elps(6100 + i * 50, 5400 - i, 10, 10, 1);
    }
    
    o.set_goal(14050, 5000, width, height, 1); //goal
  }
}
