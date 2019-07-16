class Title {
  void display_title() {
    int size = 24;
    String mes = "game";
    background(0);
    textSize(size);
    text(mes, width/2 - size*mes.length()/3, height/2);
  }
}
