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
  } //these message are nonsense lol (this gimmick is inspired by DDLC)
  
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
