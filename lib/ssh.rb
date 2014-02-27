require 'net/ssh'

class SSHConector

  def initialize(server, user, port=22, key, passwd, verbose)
    @server = server
    @user = user
    @port = port
    @key = key
    @passwd = passwd

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
      `sshpass -p @port -l @user -p @passwd @server`
    else
      system("ssh -p #{@port} -l #{@user} -i #{@key} #{@server}")
    end
  end

end
