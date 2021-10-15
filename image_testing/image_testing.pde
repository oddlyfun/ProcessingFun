PImage img;
int w,h;
float x,y;

ArrayList<cell> cellList;

void setup()
{
  size(600,600);
 // blendMode(ADD);
  
  img = loadImage("oddlyfun.png");
   w = img.width;
   h = img.height;
   x = 0;
   y = 0;
   
   img.loadPixels();
   
   cellList = new ArrayList<cell>();
   
   float offw = (width/2) - (img.width/2);
   float offh = (height/2) - (img.height/2);
   
   for( int i = 0; i < img.pixels.length; i++ )
   {
     cellList.add( new cell(x,y,img.pixels[i]) );
     cellList.get(i).enabled = true;
     cellList.get(i).set_offset(offw,offh);
        
     x++;
     if ( x >= w )
     {
       x = 0;
       y++;
     }
   }

  //cellList.get(2000).enabled = true;

}



void draw()
{  
  background(0);
  
   for( int i = 0; i < cellList.size(); i++ )
   {
    cellList.get(i).display(); 
   }
}
