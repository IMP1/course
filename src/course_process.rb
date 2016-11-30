require 'socket'
require_relative 'protocol'
require_relative 'user'
require_relative 'scheduler'
require_relative 'database'

require_relative 'log'

module Course

    @@logger = Logger.new("Course Process")
    
    def self.setup(admin_username, admin_password)
        if admin_username.nil?
            admin_username = User.create_username()
        end
        if admin_password.nil?
            admin_password = User.create_password()
        end
        @@logger.inform "User set up: #{admin_username.inspect}, with password #{admin_password.inspect}."
        CourseDatabase.install(admin_username, admin_password)
    end

    def self.begin()
        return if running?
        @@logger.debug "Initialising scheduler..."
        s = Thread.new {
            scheduler = SchedulingThread.new()
            scheduler.run()
        }
        @@logger.debug "Done."
        s.join()
    end

    def self.send_to_main_proc(*message)
        @@logger.debug "Checking for existing instances..."
        begin
            s = TCPSocket.new('localhost', SchedulingThread::SCHEDULER_PORT)
            welcome = s.gets.chomp
            if Protocol.connection?(welcome)
                @@logger.debug "Found existing instance."
                s.puts(message.join(" "))
                reply = s.gets.chomp
                return Protocol.success?(reply)
            end
            s.close()
            @@logger.debug "None found."
            return false
        rescue
            s.close() if !s.nil?
            @@logger.debug "None found."
            return false
        end
    end

    def self.running?()
        return send_to_main_proc(SchedulingThread::PING_COMMAND)
    end

    def self.stop(hard=false)
        return send_to_main_proc(SchedulingThread::KILL_COMMAND, hard ? "hard" : nil)
    end

    def self.refresh_scheduler()
        @@logger.debug "sending refresh command..."
        return send_to_main_proc(SchedulingThread::RESET_COMMAND)
    end

    def self.uninstall()
        @@logger.debug "Uninstalling..."
        CourseDatabase.uninstall()
        # TODO come back to this when there are databases to delete
        @@logger.debug "Done." 
    end

end

Logger.log "Course commands loaded.", "Course Process", Logger::DEBUG