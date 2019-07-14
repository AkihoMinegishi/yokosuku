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
   //do nothing
  }
  
  
  
  //自動スクロールの方向変更
  /*==================================
    引数idの値でスクロール方向の変化(障害物の動く方向)
    0:右
    1:右下
    2:下
    3:左下
    4:左
    5:左上
    6:上
    7:右上
  ==================================*/
  void change_scroll_direction(int id) {
    int[] x_directions = { 1, 1, 0,-1,-1,-1, 0, 1};
    int[] y_directions = { 0, 1, 1, 1, 0,-1,-1, 1};
    x_direction = x_directions[id];
    y_direction = y_directions[id];
  }
  
  
  //ステージの表示
  void display() {
    translate(x_pos,y_pos);          //描画座標軸の変更
    change_scroll_direction(4);      //スクロール方向の変更
    x_pos += dx * x_direction;       //座標軸xの移動
    y_pos += dy * y_direction;       //座標軸yの移動
    
    //障害物などを描画するところ-begin-//
    ellipse(300,100,50,50);
    //障害物などを描画するところ- end -//
  }
  
  
  //ゴールエリア(自機がこのアリアについたらクリア)の設定:サブクラスで実装
  void set_goal() {
    //do nothing
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
