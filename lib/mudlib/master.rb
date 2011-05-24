# The Master daemon is required by the Armos game driver
# and acts as the primary interface between the game engine
# and game world

def create
end

# called by Armos when a user attempts to connect to the game
def connect
  clone('std/connection.rb')
end
