PVector lengthdir(float _dist, float _degAangle)
{
  float _x = _dist * cos( radians(_degAangle) );
  float _y = _dist * -sin( radians(_degAangle) );
  
  return new PVector(_x,_y);
}

PVector vector_to(PVector pos, float _x, float _y)
{
  float atn = degrees( atan2(pos.x - _x ,pos.y - _y ) ) - 90;
  PVector v1 = PVector.fromAngle( radians(atn) );
  
  return v1;
}
