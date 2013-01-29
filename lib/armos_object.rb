class ArmosObject
  attr_reader :uid, :contents, :environment

  def initialize(server, uid)
    @server      = server
    @uid         = uid

    @contents    = Array.new
  end

  def load_yaml(file)
    data = YAML.load_file(file)
    mod = data['inherit']
    inherit(mod)
    from_hash(data['create'])
    if data.has_key?('contents')
      data['contents'].each { |ob| @contents << O(ob)}
    end
  end


  ### Applies ###

  def create
  end

  ### Efuns ###

  ## emulate inherit keyword from LPC
  def inherit(mod)
    path = @server.mudlib_path + 'modules/' + mod.downcase + '.rb'
    if File.file?(path)
      load(path)
      extend(Object.const_get(mod))
    end
  end

  # -- Container -- #
  def move_object(dest)
    dest = O(dest)
    return if dest == self
    @environment.contents.delete(self) unless @environment.nil?
    @environment = dest
    dest.contents << self
  end

  # -- Database -- #
  def db_get(key)
    @server.db(:get, key)
  end

  def db_set(key, val)
    @server.db(:set, key, val)
  end

  def users
    @server.sessions.collect { |s| s.user }
  end
  
  def objects
    @server.objects.keys
  end

  # -- Communication -- #
  def message(channel, message, target, exclude=[])
    target.each do |t|
        if t.respond_to?(:receive_message) and exclude.index(t).nil?
          t.receive_message(channel, message)
        end
    end
  end
  
  def tell_environment(env, message, user)
    message("tell", message, env.contents, [user])
  end

  def shout(message, user)
    message("shout", message, users, [user])
  end
  
  def write(message, user)
    message("write", message, [user])
  end

  # -- Objects -- #

  ## eval's file to ensure no errors, creates instance, and adds to global array
  def load_object(file)
    @server.load_object(file)
  end

  ## convenience method
  ## tk: use alias instead?
  def O(str)
    load_object(str)
  end

  def clone(file)
    @server.clone_object(file)
  end

  def destroy(str)
    @server.destroy_object(str)
  end

  # -- Filesystem -- #
  def get_dir(path)
    @server.file_system(:ls, path)
  end

  def read_file(path)
    @server.file_system(:cat, path)
  end
end
