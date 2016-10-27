require 'socket'
require_relative 'protocol'

class SchedulingThread
    SCHEDULER_PORT = 50031

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

    def listen_for_instructions()
        server = TCPServer.new(SCHEDULER_PORT)
        while @running
            puts "Scheduler listening for instructions" # DEBUG
            client = server.accept()
            puts "client connected" # DEBUG
            sock_domain, remote_port, remote_hostname, remote_ip = client.peeraddr
            # TODO: handle where data is coming from.
            msg = Protocol.to_message(Protocol::CONNECTION, "Connected to Course scheduler.")
            client.puts(msg)
            puts "handling instruction" # DEBUG
            handle_instruction(client, client.gets.chomp)
            client.close
        end
    end

    def handle_instruction(client, instruction)
        case instruction
        when "die"
            kill_soft()
            reply = Protocol.to_message(Protocol::SUCCESS, "")
        end
        client.puts(reply)
    end

end