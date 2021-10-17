class Cell
{
  float x,y,size;
  int pixelColor;
  boolean enabled,attached;
  PVector acc, pos;
  
  Cell(float _x, float _y, color col, float _size)
  {
     x = _x;
     y = _y;
     size = _size;
     pos = new PVector(_x,_y);
     acc = new PVector(0,0);
     pixelColor = col;

  }
  
  
  void display()
  {
    fill(pixelColor);
    rect(x,y,size,size);
  }
 
  
  
  
  
  
}
