PVector cir;
PVector dir;
float angle;


//leghtdir_x( dist, angle ) = dist * dcos( angle )
//lengthdir_y( dist, angle ) = dist * -dsin( angle )

PVector lengthdir(float _dist, float _angle)
{
  float _x = _dist * cos( radians(_angle) );
  float _y = _dist * -sin( radians(_angle) );
  
  return new PVector(_x,_y);
}


void setup()
{
  size(300,300);
  cir = new PVector(width/2 + 100, height/2);
  dir = new PVector(0,0.5);
}

void draw()
{
  background(151);
  float m1 = 0.0;
  
  PVector mv = new PVector(mouseX,mouseY);
  PVector cent = new PVector(width/2,height/2);
  
  circle(cir.x,cir.y,50);
  //circle(cent.x,cent.y,25);
  
 // line(0,0,cir.x,cir.y);
  //line(0,0,cent.x,cent.y);
   
  float bet = degrees( atan2(mouseX - cir.x ,mouseY - cir.y ) ) - 90;
  float mv_center = degrees( atan2(cent.x - cir.x ,cent.y - cir.y ) ) - 90;
  
  PVector cv1 = PVector.fromAngle( radians(mv_center) );
  cv1.y *= -1;
  
  PVector v1 = PVector.fromAngle( radians(bet) );
  v1.y = v1.y * -1;
  
 // PVector v5 = lengthdir(50,bet);
  
  //println( v1 );
  
 // circle(v5.x + cir.x ,v5.y + cir.y ,10);
  
  float dist_to_mouse = floor(PVector.dist(cir, mv));
  float dist_to_center = floor(PVector.dist(cir,cent));

  if ( dist_to_center > 10 ){
   cir.add(cv1);
  }
  
  //if ( dist_to_mouse > 10 ){
    dist_to_mouse = constrain(dist_to_mouse,0,100);
    float m2 = -map(dist_to_mouse,0,100,5,0);
    //m2 =  -constrain(m2,0,3);
   // m1 = map(dist_to_mouse,0,0,0,-1.5);
    cir.add( PVector.mult(v1,m2) );
   // cir.add(v1);
 //}

  println( dist_to_mouse + " " + m2 );

}
