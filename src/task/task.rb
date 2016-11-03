class Task

    def initialize(run_id,
                    job_id,
                    workflow_id,
                    execution_timeout=nil,
                    retries=0, 
                    retry_delay=0, 
                    on_success_callback=nil, 
                    on_failure_callback=nil, 
                    on_begin_callback=nil)
        @run_id              = run_id
        @job_id              = job_id
        @workflow_id         = workflow_id
        @execution_timeout   = execution_timeout
        @retries             = retries
        @retry_delay         = retry_delay
        @on_begin_callback   = on_begin_callback
        @on_success_callback = on_success_callback
        @on_failure_callback = on_failure_callback
        @timeout_thread      = nil
        @running             = false
        @result              = nil
    end

    def execute
        @running = true
        @on_begin_callback.call()
        if @execution_timeout != nil
            start_timeout_thread()
        end
        run_task()
        if @result.nil?
            puts "Result variable has not been set..."
        else
            finish(@result)
        end
    end

    def run_task
        #-------------------------------#
        # SUBCLASSES WILL OVERRIDE THIS #
        #-------------------------------#
    end

    def finish(success, message="")
        if !@timeout_thread.nil?
            @timeout_thread.terminate
        end
        @running = false
        if success
            @on_success_callback.call()
        else
            @on_failure_callback.call()
        end
    end

    def start_timeout_thread
        @timeout_thread = Thread.new do 
            # SETUP
            # get current timer
            while (@running)
                # handle timer ...
                # if timer > @execution_timeout
                #     finish(false, "Execution timed out #{timer}")
                # end
            end    
        end
    end

end
