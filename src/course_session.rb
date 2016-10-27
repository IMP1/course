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
            handle_command()
        end
    end

    def self.logout()
        puts "logging out..."
        exit(0)
    end

    def self.print_help()
        puts "This is still to come. Sorry. I know that's unhelpful."
    end    

    def self.handle_command()
        print "> "
        command = STDIN.gets.chomp.split(" ")
        case command[0]
        when "help", "?"
            print_help()
        when "logout", "quit", "exit"
            logout()
        when "scheduler"
            if command[1] == "refresh"
                Course.refresh_scheduler()
            else
                print_usage()
            end
        when "user"

        when "role"

        when "workflow"

        when "job"
            
        end
    end

    def self.user_command(args)

    end

    def self.role_command(args)

    end

    def self.workflow_command(args)

    end

    def self.job_command(args)

    end

end