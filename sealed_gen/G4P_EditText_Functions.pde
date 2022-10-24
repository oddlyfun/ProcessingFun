public void displayEvent(String name, GEvent event) {
  String extra = " ";
  print(name + "   ");
  switch(event) {
  case CHANGED:
    //println("CHANGED " + extra);
    break;
  case SELECTION_CHANGED:
    //println("SELECTION_CHANGED " + extra);
    break;
  case LOST_FOCUS:
    println("LOST_FOCUS " + extra);
    clear_screen = true;
    search_mode = false;
    break;
  case GETS_FOCUS:
    println("GETS_FOCUS " + extra);
    clear_screen = true;
    search_mode = true;
    break;
  case ENTERED:
    println("ENTERED " + extra);  
    break;
  default:
    println("UNKNOWN " + extra);
  }
}

public void handleTextEvents(GEditableTextControl textControl, GEvent event) { 
  displayEvent(textControl.tag, event);
  index = 0;
  start_x = 0;
  start_y = 0;
  loop();
}
