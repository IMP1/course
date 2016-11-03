require_relative 'task'

class BatchTask < Task

    def setup_task(batch_filename)
        @batch_filename = batch_filename
    end

    def run_task
        @result = system(@batch_filename)
    end

end