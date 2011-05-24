require 'rubygems'
require 'eventmachine'

module ArmosProtocol
  Up    = [27,91,65].pack('CCC')  
  Down  = [27,91,66].pack('CCC')  
  Right = [27,91,67].pack('CCC')  
  Left  = [27,91,68].pack('CCC')
  Clear = [27,91,50,75].pack('CCCC')
 
  Mode  = :line
  
  def post_init
    ## initialize character-by-character telnet mode
    if Mode == :char
      send_data [255, 251, 1].pack("CCC") ## IAC WILL ECHO
      send_data [255, 251, 3].pack("CCC") ## IAC WILL SGA
    
      ## create input buffer
      @input        = ['',0]
      @history      = []
      @history_pos  = 0
    end
   ## register connection with server
    ## tk: register call
  end

  def receive_data data
     
    return if data.match(/\377/)

    if data =~ /\r\n?/
      process @input[0]
      @input = ['',0]
    elsif data == Left
      @input[1] -= 1 if @input[1] > 0
      send_data data
    elsif data == Right
      if @input[1] < @input[0].length
        @input[1] += 1
        send_data data
      end  
    elsif data == Up
      cmd = ''
      if @history.size > 0
        @history_pos -= 1 if @history_pos > 0
        cmd.replace(@history[@history_pos])
        @input = [cmd, cmd.length]
        send_data "#{Clear}\r#{cmd}"
      end
    elsif data == Down 
      if @history.size > 0
        @history_pos += 1 if @history_pos < @history.size - 1
        cmd = @history[@history_pos]
      else
        cmd = ''
      end
      @input = [cmd, cmd.length]
      send_data "#{Clear}\r#{cmd}"
    else
     if data == "\b" and @input[1] > 0
       @input[1] -= 1
       @input[0][@input[1]] = ''
     else
      @input[0] += data
      @input[1] += 1
     end
      send_data "#{Clear}\r#{@input[0]}"
    end 
  end

  def unbind
    ## tk: remove session
  end

  def process input
    if input =~ /quit/i
      close_connection
    else
      @history << input if input != ''
      @history_pos = @history.size
      send_data "\r\n"
    end
  end
end

EventMachine::run {
  EventMachine::start_server "67.207.129.182", 9000, ArmosProtocol
}

