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
    verb, str = message.split(' ', 2)

    return '' if O('daemons/verbs.rb').parse_verb(self, verb, str)
    return message
  end

  def write_prompt
    write("> ", self)
  end

  def receive_message(channel, message)
    receive(message)
  end
end
