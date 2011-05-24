# An Armos Session ties the user's physical network connection
# to a game object. It also keeps track of whether or not the
# user's next message is being held for input
require 'rubygems'
require 'bundler/setup'

require 'mixology'
require 'eventmachine'

require 'interactive'

class ArmosSession < EventMachine::Connection
  attr_accessor :server
  attr_reader :user
  
  def initialize
    @input_flag = false
  end

  # change the associated interactive object
  def exec(user)
    unless @user.nil?
      @user.unmix(Interactive)
      @user.send(:remove_instance_variable, :@session)
    end
    @user = user
    @user.mixin(Interactive)
    @user.send(:instance_variable_set, :@session, self)
  end

  # capture and redirect user input to a specific object's method
  def lock_input(object, method, args)
    @input_object = object
    @input_method = method
    @input_args   = args
    @input_flag   = true
  end

  # handle input from the user
  def process(input)
    if @input_flag
      @input_object.send(@input_method, input, @input_args)
      @input_flag = false
      res = ''
    else
      res = @user.process_input(input)
    end

    if res == 'quit'
      close_connection
    elsif res != ''
      receive("What?\n")
    end

    @user.write_prompt
  end

  # handle output to the user
  def receive(message)
    send_data(message.gsub(/\n/,"\r\n"))
  end

  def logout
    @server.sessions.delete(self)
  end

  ### EventMachine Connection Overrides ###

  # successful connection callback
  def post_init
  end

  # data received callback
  def receive_data(data)
    process(data.chomp) unless data =~ /\377/
  end

  # connection terminated callback
  def unbind
    logout
  end
end
