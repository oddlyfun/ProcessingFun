import g4p_controls.*;

GTextField search_field;

CUBE spooky;
boolean clear_screen = true;
boolean search_mode = false;
int index = 0;
int pack_num = 0;
int start_x = 0;
int start_y = 0;
JSONArray all_cards; 
 
void setup()
{
 size(1150,1000);
 //size(200,200);
 background(51);
 textSize(16);
 
 //****
 //  G4 Controls
 //****
  G4P.setInputFont("Times New Roman", G4P.PLAIN, 14);
  search_field = new GTextField(this, 10, height - 32, 200, 20);
    
  spooky = new CUBE("data\\InnistradSpookyCube.csv");
  
  selectInput("Select a cube to process: ", "cubeSelected");
  
  spooky.gen_packs_random();
  //spooky.gen_packs_color_balance();
  //spooky.gen_packs_color_ten_seed();
  //spooky.gen_packs_rarity(8*3);
  
  all_cards = loadJSONArray("default-cards.json");
  println("Cards Loaded");

}

void cubeSelected(File selection) 
{
  if ( selection == null )
  {
    println("Window was closed without selection of a cube.");
  } else
  {
    println("Cube Selected: " + selection);
  }
}

void draw()
{
  PImage img;
  String name = "";
  
  if ( search_mode == false )
  {
    textSize(16);
    if ( clear_screen )
    {
      background(51);
      clear_screen = false;
      text("<--, -->, 1-Dump, 2-Load, 3-Sealed, 4-Csv, 9-Refresh,   Pack # "+str(pack_num+1), 50 ,height - 64);
    }
    
    // Cards that are double face throw a null pointer exception Because they are in a JSON array called card_faces [0] {0} image_uris  small

    //name = spooky.pack_list.get(pack_num).cards.get(index);
    name = spooky.get_card(pack_num,index);
    
    //JSONObject scry = loadJSONObject("https://api.scryfall.com/cards/named?exact="+name);
    img = loadImage("imgs\\"+name+".png");
    
    if ( img == null )
    {
      img = query_image(name);
    } 
   
      if ( img != null ){
        img.resize(200,0);
        image(img,start_x,start_y);
    
      
        start_x = start_x + img.width + 20;
      
      
      
        index = index + 1;
        
        if ( index % 5 == 0 )
        {
          start_x = 0;
          start_y = start_y + img.height + 20;
        }
        
        if ( index >= 15 )
        {
          noLoop();
        }
      }
  } else
  {
    // search mode is true
    
    if ( clear_screen )
    {
      background(51);
      //clear_screen = false;
    }
    
    String lookup = search_field.getText();
    String mtg_name = "";
    int pack_num = 0;
    
    boolean end_loop = false;
    for ( int i = 0; i < spooky.num_of_packs(); i++ ){
      PILE search_pile = spooky.pack_list.get(i); // return a PILE
      for ( int k = 0; k < search_pile.size(); k++ )
      {
        mtg_name = search_pile.get_card(k);
        String[] m1= match(mtg_name.toLowerCase(), lookup.toLowerCase() ); 
        
        if ( m1 != null )
        {
          pack_num = i + 1;
          println( "Pack: "+str(pack_num)+" Match: "+ mtg_name );
          name = mtg_name;
          end_loop = true;
          break;
        }
      }
      if ( end_loop ) { break; }
    }
    
    
    img = loadImage("imgs\\"+name+".png");
    if ( img == null )
    {
      img = query_image(name);
    }
    
    if ( img != null ){
      textSize(64);
      text("Pack: "+str(pack_num), 10, 128);
      image(img,width/2 - img.width/2,100);
    }
    
    //end search_mode else
  }
      
}



void keyPressed() {
  
  if ( key == CODED )
  {
    if ( keyCode == RIGHT )
    {
      clear_screen = true;
      index = 0;
      start_x = 0;
      start_y = 0;
      pack_num = pack_num + 1;
      pack_num =  constrain(pack_num,0, spooky.num_of_packs() - 1 );

      loop();
    }
    
    if ( keyCode == LEFT )
    {
      clear_screen = true;
      index = 0;
      start_x = 0;
      start_y = 0;
      pack_num = pack_num - 1;
      pack_num =  constrain(pack_num,0, spooky.num_of_packs() - 1 );

      loop();
    }
  }
  
  if ( key == '1' )
  {
    //dumps each pack into a text file
    spooky.full_dump();
    println("Packs Dumped");
  }
  
  if ( key == '2' )
  {
    clear_screen = true;
    index = 0;
    start_x = 0;
    start_y = 0;
    pack_num = 0;    
    spooky.full_load();
    println("Packs Loaded");
    loop();
  }
  
  //output the sealed pools from the packs
  if ( key == '3' )
  {
    spooky.sealed_dump();
  }
  
  //output the list as a comma seperated value file. I could search the name and it will show what the pack # is
  if ( key == '4' )
  {
    spooky.dump_csv();
  }
  
  if ( key == '9' )
  {
    clear_screen = true;
    index = 0;
    start_x = 0;
    start_y = 0;
    pack_num = 0;    
    spooky.refresh_cube();
    println("Refreshed Cube");
    loop();

  }
  
  // because work
  if ( key == '0' )
  {
    search_mode = false;
  }
    
    
}



void shuffle_pile(ArrayList<PILE> plist)
{
  for ( int a = 0; a < 4; a++ ){
    for ( int i =0; i < plist.size(); i++ )
    {
      plist.get(i).shuffle();
    }
  }
}


JSONObject find_card(String card)
{
  
  // I dont want to find ART series
  //layout  :  art_series   --- NOO
  //layout  :  normal       --- YES
  //layout  :  transform    --- YES
  //flavor_name  :  Dr. John Seward  -- NOO
  //set_name  :  Innistrad: Double Feature  -- NOO
  CARD card_obj = spooky.get_card_object(card);
    
  
 for ( int i = 0; i < all_cards.size(); i++ )
 {
   JSONObject json_card = all_cards.getJSONObject(i);
   

  // Filter the types of cards I don't want to see
   if ( json_card.getString("layout").equals("art_series") )
   {
     continue;
   }
   
  // if ( json_card.getString("set_name").equals("Innistrad: Double Feature") )
  // {
  //   continue;
  // }
   

   
   
   if ( json_card.isNull("card_faces") ){
   
     if ( card.equals(json_card.getString("name")) )
     {
       //I want to match the set and collector number so the correct card image shows up
       if ( match_set(json_card,card_obj) == false ) { continue; }
       
       if ( json_card.isNull("flavor_name") == false )
       {
         continue;
       }
       return json_card;
     }
   } else
   {
     // it's a two faced card
     JSONArray twoFace = json_card.getJSONArray("card_faces");
     JSONObject front = twoFace.getJSONObject(0);
     
     if ( card.equals(front.getString("name") ) )
     {
       //I want to match the set and collector number so the correct card image shows up
       if ( match_set(json_card,card_obj) == false ) { continue; }

       if ( front.isNull("flavor_name") == false )
       {
         continue;
       }
       return json_card;
     }
   }
 }
 
 println("Card Not Found");
 return null;

}


boolean match_set(JSONObject json_card, CARD card_obj)
{
   boolean set = json_card.getString("set").equals(card_obj.Set());
   boolean cn = json_card.getString("collector_number").equals(card_obj.Collector_Number());
   
   println("JSON: "+json_card.getString("set") +" "+json_card.getString("collector_number")+" "+ card_obj.Name() + " : " + card_obj.Set()+" "+ card_obj.Collector_Number() );
   
   
   if ( set == false || cn == false ) { return false; }
   
   return true;
}

PImage query_image(String name)
{
        //println("image does not exist");
        JSONObject scry = find_card(name);
        PImage pic;
        if ( scry != null )
        {
        
          String url="";
          if ( scry.isNull("image_uris"))
          {
            //println("split card");
            JSONArray split = scry.getJSONArray("card_faces");
            scry = split.getJSONObject(0);
            scry= scry.getJSONObject("image_uris");
          } else
          {
            scry = scry.getJSONObject("image_uris");
          }
          
          
          url = scry.getString("normal");
          pic = loadImage(url);
          pic.save("imgs\\"+name+".png");
          
          return pic;
        }
        
        return null;
}
