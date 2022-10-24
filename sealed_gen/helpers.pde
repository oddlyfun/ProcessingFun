ArrayList parse_card_list(String FileName)
{
  String[] list = loadStrings(FileName);
  ArrayList<CARD> card_list = new ArrayList<CARD>();
  
  //0 index is the headers
  for ( var a = 1; a < list.length; a++ )
  {
    StringList split = new StringList();
    String line = list[a];
    boolean quote = false;
  
  //remove the " marks
    int subs = 0;

    for ( int i =0; i < line.length(); i++ )
    {
       String s = str(line.charAt(i));
       
       if ( s.equals("\"") && quote == false )
       {
         quote = true;
       } else if ( s.equals("\"") && quote == true )
       {
         quote = false;
       }

       if ( s.equals(",") && quote == false )
       {
         //split the string
         split.append( line.substring(subs,i) );
         subs = i+1;
       }
  
    }
      split.append( line.substring(subs,line.length()) );
      CARD c = new CARD(split);
      card_list.add(c);
  } // end of loop


  return card_list;
}
