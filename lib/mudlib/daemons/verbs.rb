def parse_verb(user, verb, args)
  if verb == 'who'
    out = "Current Users:\n-----\n"
    users.each {|u| out += u.name + "\n"}
    out += "-----\n"
    write(out, user)
  elsif verb == 'say'
    args.gsub!(/(.{1,#{80}})( +|$\n?)|(.{1,#{80}})/,"\\1\\3\n\t")
    args.chop!
    shout("#{user.name} says: #{args}", user)
    write("You say: #{args}", user)
  elsif verb == 'l' or verb == 'look'
    env = user.environment
    write("#{env.short} | #{env.area}\n\n#{env.long}\n  Exits: #{env.exits.keys.join(', ')}\n", user)
  elsif verb == 'go'
    env = user.environment
    if env.exits.key?(args)
      tell_environment(env, "#{user.name} left #{args}.\n", user)
      user.move_object(env.exits[args])
      write("You go #{args}.\n", user)
      tell_environment(user.environment, "#{user.name} arrived from #{args}.\n", user)
    else
      write("You can't go that way.\n", user)
    end
  elsif verb == 'obs'
    write(objects.join(', ') + "\n", user)
  elsif verb == 'ls'
    write(get_dir("/").sort.join("\n") + "\n", user)
  elsif verb == 'cat'
    write(read_file(args) + "\n", user)
  elsif verb == 'update'
    destroy(args)
    load_object(args)
    write("#{args} has been updated\n", user)
  elsif verb == 'nod'
    shout("#{user.name} nods.\n", user)
    write("You nod.\n", user)
  elsif verb == 'chuckle'
    shout("#{user.name} chuckles.\n", user)
    write("You chuckle.\n", user)
  elsif verb == 'get'
    write("#{db_get(args)}\n", user)
  elsif verb == 'set'
    key, val = args.split(' ',2)
    write("#{db_set(key, val)}\n", user)
  else
    return false
  end
  return true
end
