class Logger

    ERROR       = 1
    WARNING     = 2
    INFORMATION = 3
    DEBUG       = 4

    @@importance_level = 4

    def initialize(source)
        @source = source
    end

    def set_level(level)
        @@importance_level = level
    end

    def error(message)
        Logger.log(message, @source, ERROR)
    end

    def warn(message)
        Logger.log(message, @source, WARNING)
    end

    def inform(message)
        Logger.log(message, @source, INFORMATION)
    end

    def debug(message)
        Logger.log(message, @source, DEBUG)
    end

    def self.log(message, source, importance)
        return if importance > @@importance_level
        puts "[#{source}] #{message}"
    end

end