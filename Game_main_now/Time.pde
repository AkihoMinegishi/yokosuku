class Time {
  int ms_whole_game, ms_measure_start;
  int stopped_time;
  boolean stop;
  
  void init_time() {
    ms_whole_game = ms_measure_start = 0;
    stop = false;
  }
  
  void measure_whole_time() {
    ms_whole_game = millis();
  }
  
  void measure_start() {
    ms_measure_start = ms_whole_game;
    stop = false;
  }
  
  int get_passed_time() {
    if(stop) {
      return stopped_time;
    }
    return ms_whole_game - ms_measure_start;
  }
  
  boolean jud_time_between(int st, int en) {    
    if(en < 0) {
      if(st <= get_passed_time()) {
        return true;
      } else {
        return false;
      }
    } else if(st < 0) {
      if(get_passed_time() <= en) {
        return true;
      } else {
        return false;
      }
    } else {
      if(st <= get_passed_time() && get_passed_time() <= en) {
        return true;
      } else {
        return false;
      }
    }
  }
  
  void stop_time() {
    if(stop == false) {
      stop = true;
      stopped_time = get_passed_time();
    }
  }
}
