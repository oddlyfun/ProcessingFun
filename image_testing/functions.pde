PVector lengthdir(float _dist, float _degAangle)
{
  float _x = _dist * cos( radians(_degAangle) );
  float _y = _dist * -sin( radians(_degAangle) );
  
  return new PVector(_x,_y);
}
