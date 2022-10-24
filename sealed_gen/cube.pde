class CUBE
{
 
  ArrayList<PILE> pack_list = new ArrayList<PILE>();
  ArrayList<CARD> card_list;
  ArrayList<PILE> pile_list = new ArrayList<PILE>();

  int cube_size = 0;


  CUBE(String CSVFileName)
  {
    card_list = parse_card_list(CSVFileName);
    cube_size = card_list.size();
  }
  
  void add_pile(PILE p)
  {
    //p.shuffle();
    pack_list.add(p);
  }


  void gen_packs_random()
  {
    PILE main = new PILE();
    PILE p;
    int cube_index = 0;

    for ( int i = 0; i < cube_size; i++ )
    {
      CARD c = card_list.get(i);
      main.add_card(c.Name());
    }

    main.shuffle(3);

    for ( int x = 0; x < floor(cube_size/15); x++ )
    {
      p = new PILE();

      for ( int k = 0; k < 15; k++ ) // repeat 15 times
      {      
        p.cards.append( main.get_card(cube_index) );
        cube_index = cube_index + 1;
      }
   
      pack_list.add(p);
    }
  }
  
  void gen_packs_color_balance()
  {
    //***************************************************************************************
    // General note is the 5 piles sorta have to be of the same size for this to work right
    //***************************************************************************************
    // 5 colored piles plus 1 other.
    // Add 1 of each colored pile to other until other is 50% of total cube. 
    // Redistrubute other back into 5 colored piles.
    // Take 3 cards from each pile to form packs of 15
    
    split_into_color_piles();
    PILE O = pile_list.get(5); // pull out the Other pile
    pile_list.remove(5); //remove the other pile from the list

    //shuffle piles
    for ( int i = 0; i < 5; i++ )
    {
      pile_list.get(i).shuffle(3);
    }
    

    // Place cards into Other until Other is 50% of the total cube size
    int half = floor(cube_size / 2);
    String cName = "";
    while( O.size() < half )
    {
      for ( int i = 0; i < 5; i++ )
      {
        cName = pile_list.get(i).get_card(0);
        O.add_card(cName);
        pile_list.get(i).remove_card(0);
      }
    }
     
      
     O.shuffle(3);
      
    //Distribute the other pile back into the 5 colored piles
    int iter = 0; // iterations
    while ( O.size() > 0 )
    {
      
      cName = O.get_card(0);
      pile_list.get(iter % 5).add_card(cName);
      O.remove_card(0);
      iter = iter + 1;
    }
    //shuffle piles
    for ( int i = 0; i < 5; i++ )
    {
      pile_list.get(i).shuffle(3);
    }
      
    // 3 from each of the 5 piles to create a pack

    
    
    for ( int x = 0; x < floor(cube_size / 15); x++ )
    {
      PILE nPack = new PILE();
      for ( int y = 0; y < pile_list.size(); y++ )
      {
        for ( int z = 0; z < 3; z++ )
        {
          
          
          cName = pile_list.get(y).get_card(0);
          pile_list.get(y).remove_card(0);
          nPack.add_card(cName);
        }
      }

      pack_list.add(nPack);
    }
      
      

  }
  

  void gen_packs_color_seed()
  {
    //***************************************************************************************
    // There will be no packs without a color
    //***************************************************************************************

    split_into_color_piles();
    
    for ( int i = 0; i < pile_list.size(); i++ )
    {
      pile_list.get(i).shuffle(3); //shuffle 3 times for reasons
    }
    
    PILE O = pile_list.get(5); // pull out the Other pile
    pile_list.remove(5); //remove the other pile from the list
    
    // reduce the number of cards in each color pile to the amount of packs the entire cube can make
    for ( int i = 0; i < pile_list.size(); i++ )
    {
      PILE p = pile_list.get(i);
      
      while( p.size() > floor(cube_size / 15) )
      {
        O.add_card(p.get_card(0));
        p.remove_card(0);
      }
    }
    
    
    O.shuffle();
    
    //place 1 of each color into first 5 slots then 10 cards from the other pile

    for( int i = 0; i < floor(cube_size/15); i++)
    {
      PILE pack = new PILE();
      //15 cards per pack
      for ( int z = 0; z < 15; z++)
      {
        if ( z < 5 )
        {
          //5 color picks
          pack.add_card(pile_list.get(z).get_card(0));
          pile_list.get(z).remove_card(0);
        } else
        {
          pack.add_card(O.get_card(0));
          O.remove_card(0);
        }
      }
      pack_list.add(pack);
    }
    //end gen_packs_color_seed
  }
  
  //**********************************************************************************
  //              10 Color seeds 5 random
  //**********************************************************************************
  void gen_packs_color_ten_seed()
  {
    //***************************************************************************************
    // There will be no packs without a color
    //***************************************************************************************

    split_into_color_piles();
    
    for ( int i = 0; i < pile_list.size(); i++ )
    {
      pile_list.get(i).shuffle(3); //shuffle 3 times for reasons
    }
    
    PILE O = pile_list.get(5); // pull out the Other pile
    pile_list.remove(5); //remove the other pile from the list
    
    // reduce the number of cards in each color pile to the amount of packs the entire cube can make
    for ( int i = 0; i < pile_list.size(); i++ )
    {
      PILE p = pile_list.get(i);
      
      while( p.size() > floor(cube_size / 15)*2 )
      {
        O.add_card(p.get_card(0));
        p.remove_card(0);
      }
    }
    
    
    O.shuffle();
    
    //place 1 of each color into first 10 slots then 5 cards from the other pile

    for( int i = 0; i < floor(cube_size/15); i++)
    {
      PILE pack = new PILE();
      //15 cards per pack
      for ( int z = 0; z < 15; z++)
      {
        if ( z < 10 )
        {
          //5 color picks
          pack.add_card(pile_list.get(z % 5).get_card(0));
          pile_list.get(z % 5).remove_card(0);
        } else
        {
          pack.add_card(O.get_card(0));
          O.remove_card(0);
        }
      }
      pack_list.add(pack);
    }
    //end gen_packs_color_seed
  }
  
  //**********************************************************************************
  //      Rarity Split -> Checks for Duplicates within a pack
  //**********************************************************************************
  void gen_packs_rarity(int num_of_packs)
  {
    //pack break-down
    //rare or mythic    1
    //uncommon          4
    //common            10
    // Initialize 3 piles Common,Uncommon,Rare/Mythic
    for ( int i = 0; i < 3; i++)
    {
      PILE p = new PILE();
      pile_list.add(p);
    }
    
    // split cards into piles of C/U/R
    
    CARD tmp_card;
    String rarity = "";
    
    for ( int a = 0; a < card_list.size(); a++ )
    {
      tmp_card = card_list.get(a);
      rarity = tmp_card.Rarity();
      
      if ( rarity.equals("common") )
      {
        pile_list.get(0).add_card(tmp_card.Name());
      } else if ( rarity.equals("uncommon") )
      {
        pile_list.get(1).add_card(tmp_card.Name());
      } else
      {
        pile_list.get(2).add_card(tmp_card.Name());
      }
    }
    
    // Got three piles of rarity
    // I need to check if there are enough cards each rarity before going forward
    int min_com = 10 * num_of_packs;
    int min_ucm = 4 * num_of_packs;
    int min_ram = 1 * num_of_packs;
    
    
    boolean iFailed= false;
    if ( pile_list.get(0).size() < min_com ) { println("Not enough commons"); iFailed = true; }
    else if ( pile_list.get(1).size() < min_ucm ) { println("Not enough uncommons"); iFailed = true; }    
    else if ( pile_list.get(2).size() < min_ram ) { println("Not enough rares/mythics"); iFailed = true; }  
    
    if ( iFailed == false )
    {
      
      
      
      // Generate packs based on rarity
      //Pull out the differnent piles so its easier
      PILE com = pile_list.get(0);
      PILE ucm = pile_list.get(1);
      PILE ram = pile_list.get(2);
      
      for( int a = 0; a < num_of_packs; a++)
      {
              PILE p = new PILE();
        for ( int i = 0; i < 15; i++ )
        {
          //Rare
          if ( i == 0 ){
            int ran_ram = int(random( ram.size() ));
            p.add_card(ram.get_card(ran_ram));
            ram.remove_card(ran_ram);
          } else if ( i > 0 && i < 5 ){
            //uncommons 1-4
            boolean tryagain = true;
            while ( tryagain == true )
            {
              int ran_ucm = int(random(ucm.size()));
              String cname = ucm.get_card(ran_ucm);
              tryagain = p.card_exists(cname);
              if ( tryagain == false )
              {
                p.add_card(cname);
                ucm.remove_card(ran_ucm);
              }
            }
          } else if ( i >= 5 && i < 15 ) //trying all random no duplicates first
          {
            // commons 5-9 (random no color balance) 10-14 ( one of each color WUBRG )
            boolean tryagain = true;
            while ( tryagain == true )
            {
              int ran_com = int(random(com.size()));
              String cname = com.get_card(ran_com);
              tryagain = p.card_exists(cname);
              if ( tryagain == false )
              {
                p.add_card(cname);
                com.remove_card(ran_com);
              }
            }
          }
        
        }
        
        // add pack to list
        pack_list.add(p);      
      }
      
    } else
    {
      gen_packs_random();
    }
    
    
  }

  //**********************************************************************************
  //
  //**********************************************************************************
  
  
  
  void split_into_color_piles()
  {
    // Initialize 5+1 piles (WUBRG)+ Other
    for ( int i = 0; i < 6; i++)
    {
      PILE p = new PILE();
      pile_list.add(p);
    }
    
    // Go through each cards and put it into a pile
    CARD tmp_card;
    String colr = "";
    for ( int a = 0; a < card_list.size(); a++ )
    {
      tmp_card = card_list.get(a);
      colr = tmp_card.Color();

      //Char workaround would trigger on WU because the first char is W and fail on a 0 length string
      if ( colr.length() > 1 || colr.length() == 0) { colr = "O"; }
            
      switch(colr.charAt(0)) 
      {
        case 'W': 
          pile_list.get(0).add_card(tmp_card.Name());
          break;
        case 'U': 
          pile_list.get(1).add_card(tmp_card.Name());
          break;
        case 'B': 
          pile_list.get(2).add_card(tmp_card.Name());
          break;
        case 'R': 
          pile_list.get(3).add_card(tmp_card.Name());
          break;
        case 'G': 
          pile_list.get(4).add_card(tmp_card.Name());
          break;
        default:             
          pile_list.get(5).add_card(tmp_card.Name());
          break;
      }
    }
  }
  

  String get_card(int packNum, int packIndex)
  {
    return pack_list.get(packNum).get_card(packIndex);
  }
  
  // search for the card object
  CARD get_card_object( String name )
  {
    for ( int i = 0; i < card_list.size(); i++ )
    {
      CARD c = card_list.get(i);
      if ( name.equals(c.Name()) )
      {
        return c;
      }
    }
    
    return null;
  }
  
  void full_dump()
  {
    for( int i=0; i < this.pack_list.size(); i++)
    {
      int n = i + 1;
      String s = "packs\\pile-"+n+".txt";
      pack_list.get(i).dump(s);
    }
  }
  
  
  void sealed_dump()
  {
    //Dump packs in sets of 6 
    
    int runs = floor( pack_list.size() / 6 );
    int pack_index = 0;
    
        
    //String filename = "sealed-"+str( month() )  +"_"+  str( day() ) +"_"+ str( hour() )+ "_"+ str( minute() );
     String filename = "sealed"; //I don't really need multiple sealed dumps every time
    
    for ( int i = 0; i < runs; i++ )
    { // how many sets of 6 packs to combine into one sealed file
      StringList sealed = new StringList();
      
      for ( int k = 0; k < 6; k++)
      {//get six packs and output the stuff
        PILE p = pack_list.get(pack_index);
        
        for ( int z = 0; z < p.size(); z++ )
        {
          sealed.append( p.get_card(z) );
        }
        
        pack_index = pack_index + 1;
        
        
      }
      // sealed contains 6 packs worth of cards
      saveStrings("sealed\\"+filename+"_"+str(pack_index - 5 )+"-"+str(pack_index)+".txt", sealed.array() );
    }
    println("Sealed Dumped");
  }
  
  
  void full_load()
  {
    int index = 1;
    String s = "packs\\pile-"+str(index)+".txt";
    PILE p = new PILE(s);
    
    if ( p.size() > 0 )
    {
      this.pack_list.clear(); // clear the current list
    
      // load every pack that exists with the format "pile-#.txt"
      while( p.size() != 0 )
      {
        this.add_pile(p);
        
        index = index + 1;
        s = "packs\\pile-"+str(index)+".txt";
        p = new PILE(s);
      }
    }
  }
  
  int num_of_packs()
  {
    return pack_list.size();
  }
  
  void dump_csv()
  {
    StringList cards = new StringList();
    String s = "Name,Pack#";
    
    for ( int i = 0; i < this.pack_list.size(); i++ )
    {
      PILE p = this.pack_list.get(i);
      for ( int k = 0; k < p.size(); k++ )
      {
        String name = p.get_card(k);
        s = "\""+name+"\"" + "," + str(i+1); // escape quotes so card names with commas work
        cards.append(s);
      }
    }
    
    println("Dumping data\\spooky_cards.csv");
    saveStrings("data\\spooky_cards.csv",cards.array());
    
  }
  
  void dump_booster_list()
  {
    // take the pack list and format it to create custom packs to draft instead of relying on the website to generate packs
    StringList cards = new StringList();
    String s = "";
    int boost_num = 24;
    
    //for ( int i = 0; i < this.pack_list.size(); i++ )
    for ( int i = 0; i < boost_num; i++ )
    {
      PILE p = this.pack_list.get(i);
      for ( int k = 0; k < p.size(); k++ )
      {
        //Card format ' 1  <CARDNAME> (<SET>) <COLLECTOR_NUM> '
        String name = p.get_card(k);
        
        CARD c = get_card_object(name);
        String set = c.Set();
        String coln = c.Collector_Number(); 
        
        s = "1 "+name+" ("+set+") "+coln; 
        cards.append(s);
      }
      cards.append("");
    }
    
    println("Dumping data\\Boosters.txt");
    saveStrings("data\\Boosters.txt",cards.array());
    
  }
  
  void refresh_cube()
  {
    pack_list.clear();
    gen_packs_random();
  }
  
  
  
}
