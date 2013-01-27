def create
  inherit "Room" 

  @area  = "The Blackjack"
  @short = "Deck"
  @long  = <<EndText
  You stand on the deck of the world's only known airship - Setzer's Blackjack.
All around a blue skies dotted by white clouds, while the countryside drifts by
far below. The controls for the ship are nearby while a large staircase descends
below to the gambling parlor and staterooms.
EndText
  @items = {
    "sky"      => "It's blue.",
    "clouds"   => "They are white",
    "controls" => "A large steering wheel and other instruments",
    "deck"     => "Polished wooden planks",
    "stairs"   => "They lead downward"
  }
  @exits = {
    "down"    => "realms/airship/parlor.rb",
    "sfigaro" => "realms/south_figaro/entrance.rb"
  }
  @contents << O("realms/airship/porter.rb")
end 
