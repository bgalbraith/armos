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
    verb, args = message.split(' ', 2)
    env = self.environment

    # quitting?
    if verb == 'quit'
      env.contents.delete(self) unless env.nil?
      env = nil
      return 'quit'
    end

    # shortcut for room exits
    if env.exits.key?(verb)
      args = verb
      verb = 'go'
    end

    # is it a known verb
    verb = 'look' if verb == 'l'
    cmd = O("verbs/#{verb}.rb")
    if not cmd.nil?
      cmd.action(self, args)
      return ''
    end

    return '' if O('daemons/verbs.rb').parse_verb(self, verb, args)
    return message
  end

  def write_prompt
    write("> ", self)
  end

  def receive_message(channel, message)
    receive(message)
  end
end
