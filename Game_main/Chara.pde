class Chara {
  float cx, cy, cd = 30.0, cr = cd / 2.0;
  int lifemax = 3, life = 3, dam = 3;
  color chcol;
  boolean playing = true;

  void init_chara() {
    cx = width / 8;
    cy = height / 2;
    chcol = color(128, 255, 0);
    life = lifemax;
    playing = true;
  }
  
  void draw_chara() {
    fill(chcol);
    pushMatrix();
    ellipse(cx, cy, cd, cd);
    popMatrix();
  }
  
//=================================================================================================//
//collision_detection//
//===================//
  boolean chara_is_in_window(float area[]) {
    if(area[0] <= cx + cd / 2 && cx - cd / 2 <= area[1] 
       && area[2] <= cy + cd / 2 && cy - cd / 2 <= area[3]) {
      return false;
    } else {
      return true;
    } 
  }
  
  boolean ifsafe_elps(float sets[]) {
    //sets[] :broken_point_matrix
    float ex = sets[0], ey = sets[1], ew = sets[2], eh = sets[3];
    if(pow(cx - ex, 2) * pow(ew / 2.0 + cr, -2) + pow(cy - ey, 2) * pow(eh / 2.0 + cr, -2) <= 1) {
      return false;
    } else {
      return true;
    }
  }
  boolean ifsafe_rect(float status[]) {
    float rx = status[0], ry = status[1], rw = status[2], rh = status[3];
    if(rx <= cx + cd/2 && cx - cd/2 <= rx + rw &&
       ry <= cy + cd/2 && cy - cd/2 <= ry + rh) {
      return false;
    } else {
      return true;
    }
  }
  
//=================================================================================================//


//=================================================================================================//
//      //
//======//
  void damage() {
    life -= dam;
    if(life < 0) {
      life = 0;
      playing = false;
      chcol = color(128, 0, 0);
    }
  }

  boolean is_dead() {
    if(life <= 0) {
      return true;
    } else {
      return false;
    }
  }
//=================================================================================================//


  
//=================================================================================================//
//cahra-move-processing//
//====================//
  void move_chara(float stepx, float stepy) {
    if(playing) {
      if((0 <= cx - cd / 2 && stepx < 0) || (cx + cd / 2 <= width && stepx > 0)) {
        cx += stepx;
      }
      if((0 <= cy - cd / 2 && stepy < 0) || (cy + cd / 2 <= height && stepy > 0)) {
        cy += stepy;
      }
      if(cx - cd / 2 < 0) {
        cx = cd / 2;
      } else if(width < cx + cd / 2) {
        cx = width - cd / 2;
      }
      if(cy - cd / 2 < 0) {
        cy = cd / 2;
      } else if(height < cy + cd / 2) {
        cy = height - cd / 2;
      }
    }
  }

  void warp_chara(float dx, float dy) {
    if(playing) {
      cx = dx;
      cy = dy;
    }
  }
  
//=================================================================================================//  
}
