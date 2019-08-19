class Saves {
  int save_len = 50;
  String file_name = "save_file\\save.chr";
  
  char[] file = new char[save_len];
  String[][][] pat = new String[3][save_len][2];
  boolean ifnew_file = false, ifright_file = true, ifask_load_file = true, ifshow_penalty = false;
  boolean ifsave_screen = false;
  
  PrintWriter output;
  BufferedReader input;
  
  Saves() { 
    String[] key_str = new String[4];
    String[] mks_str = new String[5];
    String[] cnt_str = new String[5];
    String[] set_str = {"0"};
  
    for(int i = 0; i < 3; i++) {
      if(i == 0) {
        int[] key_id = {1, 36, 44, 47};
        for(int j = 0; j < 4; j++) {key_str[j] = str(i);}
        int[] chk_id = {0, 8, 18, 19, 25, 32, 35, 49};
        String[] chk_str = {"5", "7", "11", "7", "3", "5", "3", "11"};      
        int[] dum_id = {4, 16, 37, 38, 39, 46};//4 12 26 27 28 31
        String[] dum_str = {"0", "Z", "Z", "Z", "0", "0"};      
        int[] mks_id = {7, 11, 24, 28, 41};
        for(int j = 0; j < 5; j++) {mks_str[j] = str(j);}
        int[] dmk_id = {17, 26, 31, 45, 48};     
        int[] set_id = {27};
        int[] dst_id = {40};
        int[] cnt_id = {2, 5, 12, 20, 29};
        for(int j = 0; j < 5; j++) {cnt_str[j] = str(2*j);}
        int[] dct_id = {9, 14, 22, 33, 42};
      
        set_pat_ele(i, key_id, key_str, "key");
        set_pat_ele(i, chk_id, chk_str, "chk");
        set_pat_ele(i, dum_id, dum_str, "dum");
        set_pat_ele(i, mks_id, mks_str, "mks");
        set_pat_ele(i, dmk_id, mks_str, "dmk");
        set_pat_ele(i, set_id, set_str, "set");
        set_pat_ele(i, dst_id, set_str, "dst");
        set_pat_ele(i, cnt_id, cnt_str, "cnt");
        set_pat_ele(i, dct_id, cnt_str, "dct");
        
      } else if(i == 1) {
        
        int[] key_id = {0, 1, 13, 48};
        for(int j = 0; j < 4; j++) {key_str[j] = str(i);}
        int[] chk_id = {2, 8, 9, 10, 25, 32, 43, 49};
        String[] chk_str = {"11", "3", "5", "7", "11", "7", "3", "5"};      
        int[] dum_id = {3, 16, 24, 29, 35, 41};
        String[] dum_str = {"0", "Z", "Z", "0", "Z", "0"};  
        int[] mks_id = {7, 19, 20, 33, 34};
        for(int j = 0; j < 5; j++) {mks_str[j] = str(j);}
        int[] dmk_id = {21, 28, 38, 42, 47};     
        int[] set_id = {6};
        int[] dst_id = {46};
        int[] cnt_id = {4, 11, 14, 30, 39};
        for(int j = 0; j < 5; j++) {cnt_str[j] = str(2*j);}
        int[] dct_id = {17, 22, 26, 36, 44};
        
        set_pat_ele(i, key_id, key_str, "key");
        set_pat_ele(i, chk_id, chk_str, "chk");
        set_pat_ele(i, dum_id, dum_str, "dum");
        set_pat_ele(i, mks_id, mks_str, "mks");
        set_pat_ele(i, dmk_id, mks_str, "dmk");
        set_pat_ele(i, set_id, set_str, "set");
        set_pat_ele(i, dst_id, set_str, "dst");
        set_pat_ele(i, cnt_id, cnt_str, "cnt");
        set_pat_ele(i, dct_id, cnt_str, "dct");
        
      } else {
        
        int[] key_id = {1, 6, 31, 45};
        for(int j = 0; j < 4; j++) {key_str[j] = str(i);}
        int[] chk_id = {0, 5, 8, 17, 21, 25, 32, 49};
        String[] chk_str = {"7", "3", "11", "5", "11", "5", "3", "7"};      
        int[] dum_id = {11, 16, 27, 37, 41, 44};
        String[] dum_str = {"Z", "0", "0", "Z", "Z", "0"};      
        int[] mks_id = {46, 38, 36, 26, 22};
        for(int j = 0; j < 5; j++) {mks_str[j] = str(j);}
        int[] dmk_id = {33, 30, 20, 4, 2};
        int[] set_id = {7};
        int[] dst_id = {3};
        int[] cnt_id = {47, 42, 34, 23, 14};
        for(int j = 0; j < 5; j++) {cnt_str[j] = str(2*j);}
        int[] dct_id = {39, 28, 18, 12, 9};
        
        set_pat_ele(i, key_id, key_str, "key");
        set_pat_ele(i, chk_id, chk_str, "chk");
        set_pat_ele(i, dum_id, dum_str, "dum");
        set_pat_ele(i, mks_id, mks_str, "mks");
        set_pat_ele(i, dmk_id, mks_str, "dmk");
        set_pat_ele(i, set_id, set_str, "set");
        set_pat_ele(i, dst_id, set_str, "dst");
        set_pat_ele(i, cnt_id, cnt_str, "cnt");
        set_pat_ele(i, dct_id, cnt_str, "dct");
      }
    }
  }
  
  void set_pat_ele(int patid, int ids[], String strs[], String mk) {
    int len = ids.length;
    if(mk == "cnt" || mk == "dct") {
      for(int i = 0; i < len; i++) {
        pat[patid][ids[i]][0] = mk;
        pat[patid][ids[i]][1] = strs[i];
        pat[patid][ids[i]+1][0] = mk;
        pat[patid][ids[i]+1][1] = str(int(strs[i])+1);
      }
    } else {
      for(int i = 0; i < len; i++) {
        pat[patid][ids[i]][0] = mk;
        pat[patid][ids[i]][1] = strs[i];
      }
    }
  }
  
  void get_file() {
    String ln = "";
    char[] arr = new char[save_len];
    boolean catch_ln = false;
    
    input = createReader(file_name);
    while(ln != null) {
      try {
        ln = input.readLine();
      }
      catch(NullPointerException e) {               // when save_file/ or sv.txt does not exist
        output = createWriter(file_name);
        ln = null;
      }
      catch(IOException e) {
        ln = null;
      }
      if(ln != null) {
        catch_ln = true;
        arr = ln.toCharArray();
      }
    }
    
    //fill new file when sv.txt is null
    if(!catch_ln) {
      output = createWriter(file_name);
      for(int i = 0; i < save_len; i++) {
        output.print("0");
        arr[i] = '0';
      }
      output.flush();
      output.close();
    }
    file = arr;
  }
  
  void check_new_file() {
    int flag = 1;
    for(int i = 0; i < save_len; i++) {
      if(file[i] != '0') {
        flag = 0;
        break;
      }
    }
    if(flag == 1) {
      ifnew_file = true;
    } else {
      ifnew_file = false;
    }
  }
  
  int translate_char_to_int(char ch) {
    if('0' <= ch && ch <= '9') {
      return int(ch - '0');
    } else {
      return int(ch - 'A') + 10;
    }
  }
  
  void check_right_file() {
    int flag = 1;
    
    int keyn = translate_char_to_int(file[1]) % 3, setn = 0;
    int[] mksn = new int[5], cntn = new int[10];
    
    if(file.length != save_len) flag = 0;
    for(int i = 0; i < save_len; i++) {
      if(flag == 0) break;
      String mk = pat[keyn][i][0];
      
      if(!(('0' <= file[i] && file[i] <= '9') || ('A' <= file[i] && file[i] <= 'Z'))) flag = 0;
      if(mk == "key") {
        if(translate_char_to_int(file[i]) % 3 != keyn) flag = 0;
      }
      if(mk == "chk") {
        if(translate_char_to_int(file[i]) % int(pat[keyn][i][1]) != 0) flag = 0;
      }
      if(mk == "dum") {
        if(file[i] != pat[keyn][i][1].charAt(0)) flag = 0;
      }
      if(mk == "mks") mksn[int(pat[keyn][i][1])] = translate_char_to_int(file[i]);
      if(mk == "set") setn = translate_char_to_int(file[i]);
      if(mk == "cnt") cntn[int(pat[keyn][i][1])] = translate_char_to_int(file[i]);
    }
    for(int i = 0; i < save_len; i++) {
      if(flag == 0) break;
      String mk = pat[keyn][i][0];
      if(mk == "dmk") {
        if(mksn[int(pat[keyn][i][1])] + translate_char_to_int(file[i]) != 35) flag = 0;
      }
      if(mk == "dst") {
        if(setn + translate_char_to_int(file[i]) != 35) flag = 0;
      }
      if(mk == "dct") {
        if(cntn[int(pat[keyn][i][1])] + translate_char_to_int(file[i]) != 35) flag = 0;
      }
    }
    
    if(flag == 1) {
      ifright_file = true;
    } else {
      ifright_file = false;
    }
  }
  
  ///// loading ////////////////////////////////////////////////////////////////////////////////////////
  
  int[] load_dc() {
    int keyn = translate_char_to_int(file[1]) % 3;
    int[] dc = {0,0,0,0,0};
    
    for(int i = 0; i < save_len; i++) {
      if(pat[keyn][i][0] == "cnt") {
        int st_id = int(pat[keyn][i][1]) / 2;
        int digit = (int(pat[keyn][i][1])+1) % 2;
        dc[st_id] += translate_char_to_int(file[i]) * pow(16, digit);
      }
    }
    return dc;
  }
  
  boolean[] load_set() {
    int keyn = translate_char_to_int(file[1]) % 3;
    boolean[] sets = {false,false,false,false}; //knm_command, show_unlocking, unlock_5th, thx4play
    
    for(int i = 0; i < save_len; i++) {
      if(pat[keyn][i][0] == "set") {
        int setn = translate_char_to_int(file[i]);
        if(setn >= 8) {
          sets[0] = true;
          setn -= 8;
        }
        if(setn >= 4) {
          sets[1] = true;
          setn -= 4;
        }
        if(setn >= 2) {
          sets[2] = true;
          setn -= 2;
        }
        if(setn >= 1) {
          sets[3] = true;
        }
      }
    }
    return sets;
  }
  
  boolean[] load_mks() {
    int keyn = translate_char_to_int(file[1]) % 3;
    boolean[] mks = new boolean[5];
    
    for(int i = 0; i < save_len; i++) {
      if(pat[keyn][i][0] == "mks") {
        if(translate_char_to_int(file[i]) % 2 == 0) {
          mks[int(pat[keyn][i][1])] = false;
        } else {
          mks[int(pat[keyn][i][1])] = true;
        }
      }
    }
    return mks;
  }
  
  //////////////////////////////////////////////////////////////////////////////////////////////////////
  
  int rand_div(int bs) {
    int ran = int(random(36));
    while(ran % bs != 0 || ran == 0) {
      ran = int(random(36));
    }
    return ran;
  }
  
  int rand_mod(int divs, int bs) {
    int ran = int(random(36));
    while(ran % divs != bs || ran == 0) {
      ran = int(random(36));
    }
    return ran;
  }
  
  char translate_int_to_char(int num) {
    if(0 <= num && num <= 9) {
      return char(num + int('0'));
    } else {
      return char(num - 10 + int('A'));
    }
  }
  
  void write_file(int[] d_cnt, boolean knm, boolean show_ul, boolean ul5, boolean thx, boolean[] mks) {  
    int type = int(random(3)), setn = 0;
    int[] cntarr = new int[10], mks_num = new int[5];
    
    for(int i = 0; i < 5; i++) {
      int cnt = d_cnt[i];
      if(cnt >= 16*16) cnt = 16*16-1;
      cntarr[i*2] = cnt / 16;
      cnt -= cntarr[i*2] * 16;
      cntarr[i*2+1] = cnt;
    }
    
    if(knm) setn += 8;
    if(show_ul) setn += 4;
    if(ul5) setn += 2;
    if(thx) setn += 1;
    
    for(int i = 0; i < save_len; i++) {
      int con = int(pat[type][i][1]);
      if(pat[type][i][0] == "mks") {
        int sw = 0;
        if(mks[con]) sw = 1;
        mks_num[con] = rand_mod(2, sw);
      }
    }
    
    output = createWriter(file_name);
    for(int i = 0; i < save_len; i++) {
      String mk = pat[type][i][0];
      int con = int(pat[type][i][1]);
      if(mk == "key") output.print(translate_int_to_char(rand_mod(3, type)));
      if(mk == "chk") output.print(translate_int_to_char(rand_div(con)));
      if(mk == "dum") output.print(pat[type][i][1]);
      if(mk == "mks") output.print(translate_int_to_char(mks_num[con]));
      if(mk == "set") output.print(translate_int_to_char(setn));
      if(mk == "cnt") output.print(translate_int_to_char(cntarr[con]));
      if(mk == "dmk") output.print(translate_int_to_char(35 - mks_num[con]));
      if(mk == "dst") output.print(translate_int_to_char(35 - setn));
      if(mk == "dct") output.print(translate_int_to_char(35 - cntarr[con]));
    }
    output.flush();
    output.close();
    get_file();
  }
  
  int move_x = 0, move_y = 0, rect_yd = 0;
  void show_penalty() {
    int penalty_time = 6000, bug_time = 550;
    int pressKey_x = 355, stageN_x = 120, select_st_y = 265, select_st_dy = 30;
    
    if(tm.get_passed_time() <= penalty_time + bug_time) {
      background(0);
      
      textAlign(CENTER);
      fill(255);
      textSize(36);
      text("É ×ÁÎÁ ÐÌÁÙ ÔÈÅ ¢ÙÏËÏÓÕËÕ¢¿", width/2+move_x, 70+move_y);
      
      textAlign(LEFT);
      textSize(22);
      fill(220, 255, 220);
      text("Èï÷ ôï ðìáù ¯ ãèáîçå ëåù óôùìå", 80+move_x, 115+move_y);
      text("-ðòåóó ÛÅÎÔÅÒÝ", pressKey_x+move_x, 145+move_y);
      fill(255, 220, 220);
      text("Óáöå ãõòòåîô äáôá", 80+move_x, 190+move_y);
      text("-ðòåóó ÛÓÝ", pressKey_x+move_x, 190+move_y);
      fill(255);
      text("Çáíå óôáòô", 80+move_x, 235+move_y);
      text("óôáçåÁ ¨ôõôïòéáì©", stageN_x+move_x, select_st_y+move_y);
      text("-ðòåóó ÛÁÝ",       pressKey_x+move_x, select_st_y+move_y);
      text("óôáçåÂ",             stageN_x+move_x, select_st_y+select_st_dy+move_y);
      text("-ðòåóó ÛÂÝ",       pressKey_x+move_x, select_st_y+select_st_dy+move_y);
      text("óôáçåÃ",             stageN_x+move_x, select_st_y+select_st_dy*2+move_y);
      text("-ðòåóó ÛÃÝ",       pressKey_x+move_x, select_st_y+select_st_dy*2+move_y);
      text("óôáçåÄ",             stageN_x+move_x, select_st_y+select_st_dy*3+move_y);
      text("-ðòåóó ÛÄÝ",       pressKey_x+move_x, select_st_y+select_st_dy*3+move_y);
      
      if(penalty_time <= tm.get_passed_time()) {
        if(-18 < move_x) move_x -= 9;
        if(move_y < 18) move_y += 9;
        noStroke();
        fill(64);
        rect(0, -height/8+rect_yd, width, height/24);
        fill(140);
        rect(0, -height/16+rect_yd, width, height/16);
        fill(110);
        rect(0, height/22+rect_yd, width, height/22);
        rect_yd += 18;
        stroke(0);
        fill(255);
      }
    } else {
      reset_file();
      ifshow_penalty = false;
      ifask_load_file = false;
    }
  }
  
  void ask_load_file() {
    background(32);
    fill(255);
    textSize(24);
      
    textAlign(CENTER);
    text("A save file has been found.", width/2, height*3/12);
    text("Would you like to load it?", width/2, height*4/12);
    textSize(20);
    textAlign(LEFT);
    fill(255, 200, 200);
    text("Yes, contitue where I saved", width*3/20,  height*6/12);
    text("-press [Y]",                   width*14/20, height*6/12);
    fill(200, 200, 255);
    text("No, delete my existing",      width*3/20,  height*8/12);
    text("data and start a new game",   width*3/20,  height*9/12);
    text("-press [N]",                   width*14/20, height*9/12);
    
    if(ifshow_penalty) {
      show_penalty();
    }
  }
  
  void reset_file() {
    output = createWriter(file_name);
    get_file();
  }
  
  void show_save_screen() {
    background(32);
    fill(255);
    textSize(24);
    
    textAlign(CENTER);
    text("Are you sure to save the current data?", width/2, height*3/10);
    textSize(20);
    textAlign(LEFT);
    fill(255, 200, 200);
    text("Yes",       width*6/20, height*11/20);
    text("-press [Y]", width*11/20, height*11/20);
    fill(200, 255, 200);
    text("No",        width*6/20, height*13/20);
    text("-press [N]", width*11/20, height*13/20);
  }
  
  
}
