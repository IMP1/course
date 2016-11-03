

class Task

    def initialize(retries=0, 
                    retry_delay=0, 
                    on_success_callback=nil, 
                    on_failure_callback=nil, 
                    on_begin_callback=nil,
                    )
        @retries             = retries
        @retry_delay         = retry_delay
        @on_begin_callback   = on_begin_callback
        @on_success_callback = on_success_callback
        @on_failure_callback = on_failure_callback
    end

    def execute
        
    end

end
