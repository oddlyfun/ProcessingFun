PImage img;
//int[] cell;
int w,h;
float x,y;

ArrayList<cell> cellList;
/*
ArrayList<Particle> particles = new ArrayList<Particle>();

// Objects can be added to an ArrayList with add()
particles.add(new Particle());
*/
void setup()
{
  size(400,400);
  img = loadImage("download.jpg");
   w = img.width;
   h = img.height;
   x = 0;
   y = 0;
   
   img.loadPixels();
   
   cellList = new ArrayList<cell>();
   
   for( int i = 0; i < img.pixels.length; i++ )
   {
     cellList.add( new cell(x,y,img.pixels[i]) );
     cellList.get(i).enabled = true;
        
     x++;
     if ( x >= w )
     {
       x = 0;
       y++;
     }
   }


}



void draw()
{  
  background(0);
  
   for( int i = 0; i < cellList.size(); i++ )
   {
    cellList.get(i).display(); 
    cellList.get(i).force_home(); 
   }
   
    
   
   
}
