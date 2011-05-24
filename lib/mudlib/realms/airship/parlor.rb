def create
  inherit "Room"

  @area  = "The Blackjack"
  @short = "Parlor"
  @long  = <<EndText
  The gambling parlor of the Blackjack isn't as posh as those in Jidoor, but
it definitely has a swanky atmosphere. Red, plush-topped stools surround card
tables on one end, while a couple of roulette tables stand at the other. There
are staterooms down a corridor and a large staircase leading up to the deck.
EndText
  @items = {
    "stools"   => "They are red and plush-topped",
    "corridor" => "It is brightly lit",
    "stairs"   => "They lead upward"
  }
  @exits = {
    "up" => "realms/airship/deck.rb"
  }
end 
