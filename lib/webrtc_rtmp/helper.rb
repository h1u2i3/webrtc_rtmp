require "ipaddr"

module WebrtcRtmp
  module Helper
    # check the ip addr
    def check_ip(ip_string)
      IPAddr.new(ip_string).ipv4? ? ip_string : nil
    end
    
    # make sure not pass a empty string
    def check_string(string)
      string.empty? ? nil : string
    end

    # wo make sure do not use the port lower than 8000
    def check_port(port)
      (port < 8000 || port > 65535) ? nil : port
    end

    # just do raise an ArgumentError to make the user import the right args
    def raise_argument_error(arg)
      raise(ArgumentError, "The argument #{arg} is empty or not the right format!")
    end
  end
end
