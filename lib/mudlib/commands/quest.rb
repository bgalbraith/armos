# The quest command
# Displays the user's quest log
def action(user, args)
  daemon = O('daemons/quests.rb')
  text = ''
  if args.nil?
    text = "////// Quests //////\n\n"
    text += "  ==> (  0%) Airship\n\n"
    text += "   ID     Stat   Quest\t==> Booty\n"

    daemon.quests.keys.each do |id|
      quest = daemon.quests[id]
      text += "   [#{id}] (----) #{quest['name']}\t==>#{quest['reward']['text']}\n"
    end
  else
    quest = daemon.quests[args]
    if quest.nil?
      write("No quest corresponds to that ID (#{args}).\n", user)
      return
    end
    text = "////// #{quest['name']} //////\n\n"
    text += "  ==> Requirements (100%)\n\n"
    text += "   ==> Precis\n"
    text += "      Area ==> #{quest['area']}\tBooty ==> #{quest['reward']['money']} tokens\n"
    text += "     Level ==> #{quest['level'] || 'Any'}\n"
    text += "    Status ==> In Progress\n\n"
    text += quest['description'] + "\n"
    text += "  ==> The Story So Far\n"
    quest['journal'].each do |j|
      text += "\n     #{j}"
    end
  end
  write("#{text}\n",user)
end