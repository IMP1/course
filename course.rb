#!usr/bin/ruby

require 'io/console'

def print_usage()
    puts "Usage:..."
end

def course_running?()
    return false
end

command = ARGV[0]

if command == nil
    print_usage()
    exit(0)
end

def create_username()
    puts "Enter an admin username:"
    print "> "
    username = STDIN.gets.chomp
    if username.strip.empty?
        username = "admin"
    end
    return username
end

def create_password()
    puts "Enter an admin password:"
    print "> "
    password = STDIN.noecho(&:gets).chomp()
    puts
    puts "Confirm admin password: "
    print "> "
    confirmation = STDIN.noecho(&:gets).chomp()
    puts
    if password == confirmation
        if password.strip.empty?
            password = "admin"
        end
        return password
    else
        puts "\nERROR: Passwords did not match."
        return create_password()
    end
end

def start_webserver(ip, port)
    # TODO check for null
end

case command
when 'init'
    username = ARGV[1]
    password = ARGV[2]
    if username == nil
        username = create_username
    end
    if password == nil
        password = create_password()
    end
    puts "Setting up user #{username}"
    puts "password is #{password.inspect}"
when 'uninstall'
when 'login'
when 'webserver'
    if ARGV[1] == nil
        print_usage()
        exit(0)
    end
    if ARGV[1] == "begin"
        if !course_running?
            puts "Course needs to be initialised before the webserver can begin. Use"
            puts "\tcourse init"
            puts "to setup Course."
        else
            start_webserver(ARGV[2], ARGV[3])
        end
    end
end