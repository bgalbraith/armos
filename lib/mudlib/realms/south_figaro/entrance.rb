def create
  inherit "Room" 

  @area  = "South Figaro"
  @short = "Entrance"
  @long  = <<EndText
 Before you lies the thriving port town of South Figaro. Many successful
merchants reside here in grand mansions along neatly kept streets that are
alive with the hustle and bustle of the workers going about their daily
business. 
EndText
  @items = {
  }
  @exits = {
    "east" => "realms/south_figaro/stables.rb"
  }
end 
