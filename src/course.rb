require 'socket'
require_relative 'protocol'
require_relative 'scheduler'

module Course
    DEFAULT_ADMIN_USERNAME = "admin"
    DEFAULT_ADMIN_PASSWORD = "admin"

    def self.create_username()
        print "Enter an admin username: "
        username = STDIN.gets.chomp
        if username.strip.empty?
            username = DEFAULT_ADMIN_USERNAME
        end
        return username
    end

    def self.create_password()
        print "Enter an admin password: "
        password = STDIN.noecho(&:gets).chomp()
        puts
        print "Confirm admin password: "
        confirmation = STDIN.noecho(&:gets).chomp()
        puts
        if password == confirmation
            if password.strip.empty?
                password = DEFAULT_ADMIN_PASSWORD
            end
            return password
        else
            puts "\nERROR: Passwords did not match."
            return create_password()
        end
    end


    def self.setup(admin_username, admin_password)
        if admin_username.nil?
            admin_username = create_username()
        end
        if admin_password.nil?
            admin_password = create_password()
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

    def self.running?()
        puts "Checking for existing instances..."
        begin
            s = TCPSocket.new('localhost', SchedulingThread::SCHEDULER_PORT)
            msg = s.gets.chomp
            if Protocol.connection?(msg)
                puts "Found existing instance."
                s.puts("\n") # Scheduler is expecting a command.
                return true
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

    def self.refresh_scheduler()
        if running?()

        end
    end

end

