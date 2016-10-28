module Protocol
    STATUS_DIGIT_LENGTH = 2

    # States Categories
    INFORMATIONAL = 100
        CONNECTION_ESTABLISHED = 100
    SUCCESS       = 200
        COMMAND_EXECUTED       = 200
    USER_ERROR    = 300
    COURSE_ERROR  = 400

    # Major States


    # Minor States


    # TODO: work out what statuses there will be, and categorise them.

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
        status = get_status(message)
        puts message
        return status >= SUCCESS && status < SUCCESS + 100
    end

    def self.connection?(message)
       return get_status(message) == CONNECTION_ESTABLISHED
    end 

end