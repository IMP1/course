module Webserver
    DEFAULT_IP = ""
    DEFAULT_PORT = 1337

    def self.begin(ip, port)
        if ip.nil?
            ip = DEFAULT_IP
        end
        if port.nil?
            port = DEFAULT_PORT
        end
        puts "Initialising Spout..."
    end

end