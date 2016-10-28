require 'socket'
require_relative 'protocol'

class SchedulingThread
    SCHEDULER_PORT = 50031
    KILL_COMMAND  = "die"
    PING_COMMAND  = "ping"
    RESET_COMMAND = "refresh"

    def initialize()
        @running = false
    end

    def run()
        @running = true
        Thread.new {
            listen_for_instructions()
        }
        while (@running)
            # TODO: check workflows' schedules
            # TODO: create threads to run workflows when needed
            sleep(2) # DEBUG
            puts "scheduler still running..." # DEBUG
        end
    end

    def kill_soft()
        @running = false
    end

    def kill_hard()
        exit(0)
    end

    def reset()
        puts "clean as a whistle."
        # TODO: Something something...
    end

    def listen_for_instructions()
        server = TCPServer.new(SCHEDULER_PORT)
        while @running
            puts "Scheduler listening for instructions" # DEBUG
            client = server.accept()
            puts "client connected" # DEBUG
            sock_domain, remote_port, remote_hostname, remote_ip = client.peeraddr
            # TODO: handle where data is coming from.
            msg = Protocol.to_message(Protocol::CONNECTION_ESTABLISHED, "Connected to Course scheduler.")
            client.puts(msg)
            puts "handling instruction" # DEBUG
            handle_instruction(client, client.gets.chomp.split(" "))
            client.close
        end
    end

    def handle_instruction(client, commands)
        case commands[0]
        when PING_COMMAND
            reply = Protocol.to_message(Protocol::COMMAND_EXECUTED, "pong")
        when KILL_COMMAND
            if commands[1] == "hard"
                reply = Protocol.to_message(Protocol::COMMAND_EXECUTED, "You monster.")
                puts "Erngh."
                kill_hard()
            else
                reply = Protocol.to_message(Protocol::COMMAND_EXECUTED, "Good night.")
                puts "Dying gracefully..."
                kill_soft()
            end
        when RESET_COMMAND
            reset()
            reply = Protocol.to_message(Protocol::COMMAND_EXECUTED, "refreshed and rejuivinated!")
        end
        client.puts(reply)
    end

end