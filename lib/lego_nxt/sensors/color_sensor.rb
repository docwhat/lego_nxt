require 'lego_nxt/sensor_port'
require 'lego_nxt/low_level/constants'

module LegoNXT
  module Sensors
    # NXT 2.0 Color Sensor
    class ColorSensor < SensorPort
      COLORS = {
        full:    ::LegoNXT::LowLevel::SensorTypes::COLORFULL,
        red:     ::LegoNXT::LowLevel::SensorTypes::COLORRED,
        green:   ::LegoNXT::LowLevel::SensorTypes::COLORGREEN,
        blue:    ::LegoNXT::LowLevel::SensorTypes::COLORBLUE,
        passive: ::LegoNXT::LowLevel::SensorTypes::COLORNONE
      }

      # Turns on (or off for :passive) the lights
      # for sensing colors.
      def color(color)
        color_byte = COLORS.fetch(color, nil)

        fail ArgumentError, "Invalid color #{color.inspect}: It must be one of #{COLORS.keys.inspect}" if color_byte.nil?

        input_value(color_byte)
      end

      # Turns off the lights
      def off
        color(:passive)
      end

      private

      def input_value(color_byte)
        @brick.input_value(
          @port,
          color_byte,
          ::LegoNXT::LowLevel::SensorModes::RAWMODE
        )
      end
    end
  end
end
