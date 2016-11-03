

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
    end

    def execute
        @running = true
        @on_begin_callback.call()
        if @timeout_thread != nil
            Thread.new { timeout_thread }
        end
    end

    def finish
        @running = false
    end

    def on_success
        finish
        @on_success_callback.call()
    end

    def on_failure(message="")
        finish
        @on_failure_callback.call()
    end

    def timeout_thread
        # setup ...
        while (@running)
            # handle timer ...
            # if timer > @execution_timeout
            #     on_failure("Execution timed out #{timer}")
            # end
        end
    end

end
