require 'lego_nxt/low_level/types'
require 'lego_nxt/port'

module LegoNXT
  module Sensors
    # Super class for all the Sensors
    class Base < ::LegoNXT::Port
      attr_reader :brick, :port, :port_byte

      def assign_brick_and_sensor_port(brick, port_number)
        @brick = brick
        @port = port_number.to_i
        @port_byte = LegoNXT::LowLevel::UnsignedByte.new(@port - 1)
      end
    end
  end
end
