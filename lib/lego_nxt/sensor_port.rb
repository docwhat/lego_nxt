module LegoNXT
  # Super class for all the Sensors
  class SensorPort
    attr_reader :brick, :port

    def assign_brick_and_sensor_port(brick, port_number)
      @brick = brick
      @port = port_number.to_i
    end
  end
end
