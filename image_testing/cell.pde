class cell
{
  float x,y,mouse_ave;
  int pixelColor;
  boolean enabled,attached;
  PVector force, pos;
  
  cell(float _x, float _y, int col)
  {
     x = _x;
     y = _y;
     mouse_ave = 50;
     pos = new PVector(_x,_y);
     pixelColor = col;
     enabled = false;
     attached = false;
     force = new PVector(0,0);
  }
  
  void set_offset(float _x, float _y)
  {
    x = x + _x;
    y = y + _y;
    pos.x = x;
    pos.y = y;
  }
  
  void display()
  {
    stroke(pixelColor);
    point(pos.x,pos.y);
    
    if ( enabled == true )
    {
      //fill(pixelColor);
      //circle(pos.x,pos.y,5);
      add_forces();
      //check_bounds();
    }
  }
  
  
  void randomize_force()
  {
    force = PVector.random2D();
  }
  
  void add_forces()
  {
    
     float dist = PVector.dist(pos, new PVector(x,y));
     
     if ( dist > 1 ){
       PVector h1 = vector_to(new PVector(x,y), pos.x, pos.y);
       h1.y *= -1;
       
       float acc = constrain(dist,0,500);
       acc = map(acc,0,500,1,10);
       //println(acc);
       force.add( h1.mult(acc) );
     } else
     {
       pos.x = x;
       pos.y = y;
     }
     
    PVector h2 =  vector_to(pos, mouseX, mouseY);
    h2.y *= -1;
    float mouse_dist = PVector.dist(pos, new PVector(mouseX,mouseY) );
    mouse_dist = constrain(mouse_dist,0,mouse_ave);
    mouse_dist = map(mouse_dist,0,mouse_ave,5,0);
    
    force.add( h2.mult(mouse_dist) );
    pos.add(force);
     
    force.mult(0);
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
