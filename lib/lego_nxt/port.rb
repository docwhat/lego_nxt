module LegoNXT
  # Base class for Sensor and Motor ports
  class Port
    # Add hooks to run when the port is assigned.
    def on_assignment(&block)
      assignment_hooks << block
    end

    # Calls all the assignment hooks
    def call_assignment_hooks
      loop do
        hook = assignment_hooks.shift
        break if hook.nil?
        hook.call(self)
      end
    end

    private

    def assignment_hooks
      @assignment_hooks ||= []
    end
  end
end
