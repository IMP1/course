module Protocol
    STATUS_DIGIT_LENGTH = 2

    CONNECTION = 100
    SUCCESS = 200

    def self.to_message(status, msg)
        return status.to_s.rjust(STATUS_DIGIT_LENGTH, '0') + ":" + msg
    end

    def self.get_status(message)
        return message.split(":")[0].to_i
    end

    def self.get_text(message)
        return message.split(":")[1]
    end

    def self.success?(message)
        return get_status(message) == SUCCESS
    end

    def self.connection?(message)
       return get_status(message) == CONNECTION
    end 

end