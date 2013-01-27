def create
  inherit "NPC"

  @name = "Porter"
  @description = <<EndText
The porter stands smartly at attention, waiting to assist in transporting traveler's luggage to and from their compartments.
EndText
  @dialogue = {
    "default" => "Hello! How may I help you today?",
  }
end