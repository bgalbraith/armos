# The Interactive module defines a set of functions used by all interactive
# objects

module Interactive
  def session
    @session
  end
  
  def receive(message)
    self.session.receive(message)
  end

  def input_to(object, method, *args)
    self.session.lock_input(object, method, args)
  end

  def exec(to, from)
    from.session.exec(to)
  end

  def process_input(message)
    cmd, args = message.split(' ', 2)
    env = self.environment

    # quitting?
    if cmd == 'quit'
      env.contents.delete(self) unless env.nil?
      env = nil
      return 'quit'
    end

    # shortcut for room exits
    if env.exits.key?(cmd)
      args = cmd
      cmd = 'go'
    end

    # is it a known verb
    cmd = 'look' if cmd == 'l'
    verb = O("verbs/#{cmd}.rb")
    if not verb.nil?
      verb.action(self, args)
      return ''
    end

    # is it a known command
    command = O("commands/#{cmd}.rb")
    if not command.nil?
      command.action(self, args)
      return ''
    end

    return '' if O('daemons/verbs.rb').parse_verb(self, cmd, args)
    return message
  end

  def write_prompt
    write("> ", self)
  end

  def receive_message(channel, message)
    receive(message)
  end
end
