class cell
{
  float x,y;
  int pixelColor;
  boolean enabled,attached;
  PVector force, pos;
  
  cell(float _x, float _y, int col)
  {
     x = _x;
     y = _y;
     pos = new PVector(_x,_y);
     pixelColor = col;
     enabled = false;
     attached = false;
     force = PVector.random2D();
  }
  
  void display()
  {
    stroke(this.pixelColor);
    point(pos.x,pos.y);
    
    if ( enabled == true )
    {
      pos.add(force);
      check_bounds();
    }
  }
  
  
  void randomize_force()
  {
    force = PVector.random2D();
  }
  
  void force_home()
  {
    
    //circle(pos.x,pos.y,15);

    PVector a = new PVector(x,y);
    PVector acc = PVector.sub(a,pos);
    
    force.add(acc);
    //force.limit(0.5);
    force.normalize();

    
    println(force);
  }
  
  void check_bounds()
  {
    if ( pos.x < 0 || pos.x > width)
    {
      force.x = force.x * -1;
    }
    
    if ( pos.y < 0 || pos.y > height)
    {
      force.y = force.y * -1;
    }
  }
  
  
}
