require 'httparty'

class Innrm_server

  def initialize(innrm_server_ip, innrm_server_port, innrm_filter="")
    @server_ip = innrm_server_ip
    @server_port = innrm_server_port
    @filter = innrm_filter+"&format=json"
  end

  def get_stations()
    response = HTTParty.get("http://"+@server_ip+":"+@server_port+"/stations?"+@filter)

    if response.code == 200
      response.body
    end
  end
end
