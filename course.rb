#!usr/bin/ruby

require 'io/console'
require_relative 'src/course'
require_relative 'src/course_session'
require_relative 'src/webserver'

#--------------------#
# Available Commands #
#--------------------#
def course_init()
    username = ARGV[1]
    password = ARGV[2]
    Course.setup(username, password)
    Course.begin()
end

def course_uninstall()

end

def course_login()
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

def webserver_begin()
    if !Course.running?
        puts "Course needs to be initialised before the webserver can begin. Use"
        puts "\tcourse init"
        puts "to setup Course."
    else
        ip = ARGV[2]
        port = ARGV[3]
        Webserver.begin(ip, port)
    end
end

def print_usage()
    puts "Usage:..."
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
        course_init()
    when 'uninstall'
        course_uninstall()
    when 'login'
        course_login()
    when 'webserver'
        webserver_command = ARGV[1]
        if webserver_command.nil?
            print_usage()
            exit(0)
        end

        case webserver_command
        when "begin"
            webserver_begin()
        end
    end
end