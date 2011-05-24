# The Connection object is responsible for handling user login
def create 
  @name = "Nobody"
end

def name
  @name
end

def logon
  write("Welcome to the Armos Server!\n", self)
  write("Please enter your name: ", self)
  input_to(self, "process_login")
end

def process_login(name, *args)
  enter_world(name)
end

def enter_world(name)
  player = clone('std/user.rb')
  player.name = name
  shout("#{name} has joined the server.\n", self)
  exec(player, self)
  player.move_object('realms/airship/deck.rb')
  destroy(self)
end
