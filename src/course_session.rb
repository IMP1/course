module CourseSession

    def self.valid_username?(username)
        return true # TODO: check database
    end

    def self.correct_password?(username, password)
        return true # TODO: check database
    end
    
    def self.get_username(username)
        if username.nil?
            print "Enter your username: "
            username = STDIN.gets.chomp
        end
        while !valid_username?(username)
            puts "Invalid username."
            print "Enter your username: "
            username = STDIN.gets.chomp
        end
        return username
    end

    def self.attempt_password(password, username)
        if password.nil?
            print "Enter your password: "
            password = STDIN.noecho(&:gets).chomp()
            puts
        end
        return correct_password?(username, password)
    end

    def self.login(username, password)
        username = get_username(username)
        password_attempts = 5
        while password_attempts > 0
            return true if attempt_password(password, username)
            password_attempts -= 1
        end
        return false
    end

    def self.begin(username, password)
        if login(username, password)
            run()
        end
    end

    def self.run()
        while true
            print "> "
            command = STDIN.gets.chomp
            case command
            when "help", "?"
                puts "This is still to come. Sorry. I know that's unhelpful."
            when "logout"
                puts "logging out..."
                return
            end
        end
    end

end