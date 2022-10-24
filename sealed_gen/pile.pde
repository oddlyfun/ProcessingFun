class PILE
{
 
  StringList cards = new StringList();
   
  PILE(String filename)
  {
    String[] list = loadStrings(filename);
    if ( list != null ){
      for ( int i = 0; i < list.length; i++ )
      {   this.cards.append(list[i]);  }
    }

  }
  
  PILE() 
  {
  }

  void add_card(String c)
  {
    cards.append(c);
  }
  
  void remove_card(int r)
  {
    cards.remove(r);
  }
  
  int size()
  {
    return cards.size();
  }
  
  String get_card(int index)
  {
    return cards.get(index);
  }
  
  void shuffle()
  {
    cards.shuffle();
  }
  
  void shuffle(int times)
  {
    for ( int i = 0; i < times; i++ )
    {
      cards.shuffle();
    }
  }
  
  void dump()
  {
    saveStrings("pile.txt",cards.array());
  }
  
  void dump(String fname)
  {
    saveStrings(fname,cards.array());
  }
  
  boolean card_exists(String cname)
  {
    for ( int i = 0; i < cards.size(); i++ )
    {
      String s = cards.get(i);
      if ( s.equals(cname) ) { return true; }
    }
    return false;
  }
  
}
