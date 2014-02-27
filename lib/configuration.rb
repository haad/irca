class Configuration
  require "json"

  attr_reader :innrm_user
  attr_reader :innrm_key
  attr_reader :innrm_pass
  attr_reader :innrm_server
  attr_reader :innrm_port

  def initialize(conf_file)
    @conf_file=conf_file
    config = JSON.parse(File.read(conf_file))

    @innrm_user = config["innrm_user"]
    @innrm_key = config["innrm_key"]
    @innrm_pass = config["innrm_password"]
    @innrm_server = config["innrm_server_ip"]
    @innrm_port = config["innrm_server_port"]
  end

end
