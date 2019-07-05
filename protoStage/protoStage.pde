
class Stage {
  /*====================================
    x_pos       :座標軸ｘの位置
    y_pos       :座標軸ｙの位置
    dx          :x方向のスクロール度合い
    dy          :y方向のスクロール度合い
    x_direction :x軸のスクロール方向
    y_direction :y軸のスクロール方向
  ====================================*/
  int dx = 1;
  int dy = 1;
  int x_direction = -1;
  int y_direction = 0;
  int x_pos = 0;
  int y_pos = 0;
  //コンストラクタ
  Stage() {
   
  }
  
  //自動スクロールの方向変更
  void change_scroll_direction(int id) {
    int[] x_directions = { 1, 1, 0,-1,-1,-1, 0, 1};
    int[] y_directions = { 0, 1, 1, 1, 0,-1,-1, 1};
    x_direction = x_directions[id];
    y_direction = y_directions[id];
  }
  
  void display() {
    translate(x_pos,y_pos);
    x_pos += dx * x_direction;
    y_pos += dy * y_direction;
    ellipse(300,100,50,50);
  }
  
}

Stage s = new Stage();

void setup() {
  size(400, 400);
}

void draw() {
  background(255);
  s.display();
}
