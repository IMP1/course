#!usr/bin/ruby2.3

require_relative 'src/course_process'
require_relative 'src/course_session'

#--------------------#
# Available Commands #
#--------------------#
def init()
    username = ARGV[1]
    password = ARGV[2]
    Course.setup(username, password)
    Course.begin()
end

def uninstall(hard)
    if !User.login()
        puts "Invalid credentials"
        return
    end
    if !Course.stop(hard)
        puts "There was no Course to uninstall."
    end
    Course.uninstall()
end

def login()
    if !Course.running?
        puts "Course needs to be initialised before you can login. Use"
        puts "\tcourse init"
        puts "to setup Course."
    else
        username = ARGV[1]
        password = ARGV[2]
        CourseSession.begin(username, password)
    end
end

def print_usage()
    puts "usage: course <command> [args]"
    puts
    puts "Available Commands:"
    puts
    puts "Install and setup Course"
    puts "   init [username [password]]"
    puts "Uninstall Course"
    puts "   uninstall"
    puts "Login to Course"
    puts "   login [username [password]]"
end

#--------------#
# Main Process #
#--------------#
begin
    command = ARGV[0]

    if command.nil?
        print_usage()
        exit(0)
    end

    case command
    when 'init'
        init()
    when 'uninstall'
        uninstall(ARGV[1] == "hard")
    when 'login'
        login()
    else
        print_usage()
    end
end