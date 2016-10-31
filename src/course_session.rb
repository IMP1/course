require_relative 'user'
require_relative 'course'

module CourseSession

    def self.begin(username, password)
        if !User.login(username, password)
            puts "Invalid credentials"
            return
        end
        puts "Logged in as #{User::current_user}"
        while true
            print "> "
            command, args = get_command(STDIN.gets.chomp)
            handle_command(command, args)
        end
    end

    def self.logout()
        puts "logging out..."
        exit(0)
    end

    def self.print_help()
        puts "This is still to come. Sorry. I know that's unhelpful."
    end   

    def self.uninstall(hard)
        if !Course.stop(hard)
            puts "There was no Course to uninstall."
        end
        Course.uninstall()
        exit(0)
    end

    def self.get_command(line)
        if line.is_a?(String)
            args = line.split(" ")
        elsif line.is_a?(Array)
            args = line
        else
            raise "this isn't a valid comand. #{line.inspect}"
        end
        command = args[0]
        args = args[1..-1]
        return command, args
    end

    def self.handle_command(command, args)
        case command
        when "help", "?"
            print_help()
        when "logout", "quit", "exit"
            logout()
        when "uninstall"
            uninstall(args[0] == "hard")
        when "scheduler"
            scheduler_command(*get_command(args))
        when "user"
            user_command(*get_command(args))
        when "role"
            role_command(*get_command(args))
        when "workflow"
            workflow_command(*get_command(args))
        when "job"
            job_command(*get_command(args))
        end
    end

    def self.scheduler_command(command, args)
        case command
        when "refresh"
            Course.refresh_scheduler()
        else
            print_usage()
        end
    end

    def self.user_command(command, args)
        case command
        when "create"

        else
            print_usage()
        end
    end

    def self.role_command(command, args)
        case command
        when "create"

        when "add"

        else
            print_usage()
        end
    end

    def self.workflow_command(command, args)
        case command
        when "create"

        when "schedule"

        when "set-state"

        when "stats"

        when "event"

        else
            print_usage()
        end
    end

    def self.job_command(command, args)
        case command
        when "create"

        when "require"

        when "run"

        when "set-state"

        when "stats"
            
        when "event"

        else
            print_usage()
        end 
    end

end