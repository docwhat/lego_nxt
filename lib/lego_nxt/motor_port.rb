module LegoNXT
  # Super class for all the Motors
  class MotorPort
    attr_reader :brick, :port

    def assign_brick_and_motor_port(brick, port_symbol)
      @brick = brick
      @port = port_symbol.to_sym
    end
  end
end
