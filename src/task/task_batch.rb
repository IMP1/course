require_relative 'task'

class BatchTask < Task

    def initialize(batch_filename, *args)
        super(*args)
        @batch_filename = batch_filename
    end

    def run_task
        super
        @result = system(@batch_filename)
    end

end