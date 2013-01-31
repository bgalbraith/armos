def action(user, args)
  env = user.environment
  desc = env.long.clone
  desc.gsub!(/\n/,"\n\n")
  desc.gsub!(/(.{1,#{80}})( +|$\n?)|(.{1,#{80}})/,"\\1\\3\n")
  desc.chop!
  title = "#{env.short} | #{env.area}"
  obs = env.contents.select {|c| c != user}
  things = obs.collect {|c| c.name}
  if things.length > 0
    things = things.join("\n") + "\n\n"
  else
    things = nil
  end
  write("#{title}\n\n#{desc}\n#{things}  Exits: #{env.exits.keys.join(', ')}\n", user)
end