require 'net/ssh'

class SSHConector

  def initialize(server, user, port=22, key, passwd, verbose)
    @server = server
    @user = user
    @port = port
    @key = key
    @passwd = passwd
    @ssh=nil

    if verbose
      @verbose = verbose
    else
      @verbose = :info
    end
  end

  def run_command(cmd)
    puts "Running command on server #{@server} -> #{cmd}"
    stdout = ""
    if @key.nil?
      Net::SSH.start(@server, :username => @user, :port => @port, :password => @passwd, :verbose => @verbose) do |ssh|
        stdout << ssh.exec!(cmd)
        ssh.close
      end
    else
      Net::SSH.start(@server, @user, :port => @port, :keys => @key, :verbose => @verbose) do |ssh|
        stdout << ssh.exec!(cmd)
        ssh.close
      end
    end
    puts stdout
  end

  def start_shell()
    puts "Starting shell on server #{@server}, #{@port}"
    if @key.nil?
      system("sshpass -p @port -l @user -p @passwd @server")
    else
      system("ssh -p #{@port} -l #{@user} -i #{@key} #{@server}")
    end
  end

  def upload_pub_key()
    pub_key_path = File.expand_path("#{@key}.pub")
    pub_key_data = File.read(pub_key_path).chomp() if File.exists?(pub_key_path)
    puts "Uploading public key from file #{@key} to a server #{@server}, pub_key_path #{pub_key_path}"


    system("ssh -p #{@port} -l #{@user} -i #{@key} #{@server} 'mkdir -p ~/.ssh; echo \"#{pub_key_data}\" >> ~/.ssh/authorized_keys; chmod 700 ~/.ssh; chmod 644 ~/.ssh/authorized_keys'")
  end

  def start_local_port_forward(lport)
    puts "Forwarding local connections to port: #{@lport} to remote server: #{@server}:#{@port}"

    begin
      @ssh = Net::SSH.start(@server, @user, :port => @port, :keys => @key, :verbose => :debug)

      tunnel_thread = Thread.new do
        @ssh.forward.local(lport, 'localhost', lport)
      end
    end
  end

  def stop_local_port_forward(lport)
    @ssh.forward.cancel_local lport
    @ssh.close
  end
end
