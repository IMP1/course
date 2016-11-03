

class BatchTask < Task

    def initialize(batch_filename, *args)
        super(*args)
        @batch_filename = batch_filename
    end

    def execute
        super
        result = system(@batch_filename)
        if result
            on_success
        else
            on_failure
        end
    end

end