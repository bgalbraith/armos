# Quest daemon
# Services:
#   Provide lists and info for quest command
#   Parses and stores quest definition files
#   Handles quest status updates and rewards for users
def create
  @quests = data = YAML.load_file(@server.mudlib_path+'realms/airship/quests.yaml')
end

def quests
  @quests
end