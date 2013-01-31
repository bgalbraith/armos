require 'rubygems'
require 'bundler/setup'

require 'eventmachine'
require 'redis'

require 'armos_session'
require 'armos_object'

# The Armos Game Driver
# Handles and manages network connections

class Armos
  attr_reader :sessions, :objects, :mudlib_path

  def initialize(port, host)
    @port = port 
    @host = host
    
    @mudlib_path = "mudlib/"

    ## global array of user sessions
    @sessions = Array.new

    ## global hash of game objects
    ## objects[id] = ob
    @objects      = Hash.new
    @object_count = 0

    master  = "master.rb"
    @master = load_object(master)

    @redis  = Redis.new
  end


  def start
    EM.start_server(@host, @port, ArmosSession) do |con|
      con.server = self
      @sessions << con
      con.exec(@master.connect)
      con.user.logon
    end
  end
 
  # load object ref
  def load_object(ref, clone=false)
    id = str = resolve_reference(ref)
    if clone
      id += '#' + (@objects.size + 1).to_s
    else 
      ob = @objects[str]
      return ob unless ob.nil?
    end

    path = @mudlib_path + str 
    ob = ArmosObject.new(self, id)
    if File.file?(path)
      if path[-2,2] == 'rb'
        res = ob.instance_eval(File.read(path))
      else
        ob.load_yaml(path)
      end
      if res.nil?
        ob.create
      else
        return res  
      end
    else
      return nil
    end
    @objects[id] = ob
  end

  ## create a copy of the object
  ## tk: verify that the object can be cloned
  def clone_object(ref)
    load_object(ref, true)
  end

  def destroy_object(ref)
    @objects.delete(resolve_reference(ref))
  end

  def find_object(ref)
    @objects[resolve_reference(ref)]
  end
  
  def resolve_reference(ob)
    case ob.class.to_s
      when "ArmosObject" then return ob.uid 
      when "String"      then return ob
    end
  end

  ## all file system operations run through here
  def file_system(op, path)
    path = @mudlib_path + path
    if op == :ls
      return Dir.entries(path)
    elsif op == :cat
      if File.file?(path)
	return File.read(path)
      else
	return "File not found"
      end
    end
  end

  def db(op, key, val=nil)
    case op
      when :get then @redis.get(key)
      when :set then @redis.set(key, val)
    end
  end
end
