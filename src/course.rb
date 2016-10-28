require 'socket'
require_relative 'protocol'
require_relative 'user'
require_relative 'scheduler'

module Course
    
    def self.setup(admin_username, admin_password)
        if admin_username.nil?
            admin_username = User.create_username()
        end
        if admin_password.nil?
            admin_password = User.create_password()
        end
        puts "User set up: #{admin_username.inspect}, with password #{admin_password.inspect}."
    end

    def self.begin()
        return if running?
        puts "Initialising scheduler..."
        s = Thread.new {
            scheduler = SchedulingThread.new()
            scheduler.run()
        }
        puts "Done."
        s.join()
    end

    def self.send_to_main_proc(*message)
        puts "Checking for existing instances..."
        begin
            s = TCPSocket.new('localhost', SchedulingThread::SCHEDULER_PORT)
            welcome = s.gets.chomp
            if Protocol.connection?(welcome)
                puts "Found existing instance."
                s.puts(message.join(" "))
                reply = s.gets.chomp
                return Protocol.success?(reply)
            end
            s.close()
            puts "None found."
            return false
        rescue
            s.close() if !s.nil?
            puts "None found."
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
        puts "sending refresh command..."
        return send_to_main_proc(SchedulingThread::RESET_COMMAND)
    end

    def self.uninstall()
        puts "Deleting local databses..."
        # TODO come back to this when there are databases to delete
        puts "Done." 
    end

end

puts "Course commands loaded."