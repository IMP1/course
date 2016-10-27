require 'io/console'

module User
    DEFAULT_ADMIN_USERNAME = "admin"
    DEFAULT_ADMIN_PASSWORD = "admin"
    PASSWORD_ATTEMPTS = 5

    @@current_user = nil

    def self.create_username()
        print "Enter username: "
        username = STDIN.gets.chomp
        if username.strip.empty?
            username = DEFAULT_ADMIN_USERNAME
        end
        return username
    end

    def self.create_password()
        loop do
            print "Enter password: "
            password = STDIN.noecho(&:gets).chomp()
            puts
            print "Confirm password: "
            confirmation = STDIN.noecho(&:gets).chomp()
            puts
            if password == confirmation
                if password.strip.empty?
                    password = DEFAULT_ADMIN_PASSWORD
                end
                return password
            end
            puts "\nERROR: Passwords did not match."
        end
    end

    def self.username_exists?(username)
        return true # TODO: query DB
    end

    def self.correct_password?(username, password)
        return true # TODO: query DB
    end

    def self.try_password(password, username)
        if password.nil?
            print "Enter your password: "
            password = STDIN.noecho(&:gets).chomp()
            puts
        end
        return correct_password?(username, password)
    end

    def self.get_username(username)
        if username.nil?
            print "Enter your username: "
            username = STDIN.gets.chomp
        end
        while !username_exists?(username)
            puts "Invalid username."
            print "Enter your username: "
            username = STDIN.gets.chomp
        end
        return username
    end

    def self.login(username, password)
        username = get_username(username)
        password_attempts = PASSWORD_ATTEMPTS
        while password_attempts > 0
            if try_password(password, username)
                @@current_user = username
                return true 
            end
            password_attempts -= 1
        end
        return false
    end

    def self.current_user()
        return @@current_user
    end

end