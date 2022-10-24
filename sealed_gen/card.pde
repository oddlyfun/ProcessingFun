class CARD
{
  StringList info = new StringList();
  CARD(StringList i)
  {
    info = i;
  }
  
// The string list better have at least 4 fields (^_^)

//Size=16 [ "Name", "CMC", "Type", "Color", "Set", "Collector Number", "Rarity", 
//"Color Category", "Status", "Finish", "Maybeboard", "Image URL", 
//"Image Back URL", "Tags", "Notes", "MTGO ID" 

  String Name()  {  return Sanitize(info.get(0));  }
  
  String Color() {  return Sanitize(info.get(3));  }
  
  String Type()  {  return Sanitize(info.get(2));  }
  
  String Set()   {  return Sanitize(info.get(4));  }
  
  String Rarity()   {  return Sanitize(info.get(6));  }
  
  String Collector_Number()   {  return Sanitize(info.get(5));  }
  
  String Sanitize(String s)
  {
    if ( s.length() > 0 ) 
    {
      if ( str(s.charAt(0)).equals("\"") )
      {
        return s.substring(1,s.length() - 1);
      } else
      {
        return s;
      }
    } else
    {
      return "";
    }
  }
  
}
