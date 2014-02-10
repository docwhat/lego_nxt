require 'lego_nxt/sensors/base'
require 'lego_nxt/low_level/constants'

module LegoNXT
  module Sensors
    # NXT 2.0 Color Sensor
    class ColorSensor < Base
      COLORS = {
        full:    ::LegoNXT::LowLevel::SensorTypes::COLORFULL,
        red:     ::LegoNXT::LowLevel::SensorTypes::COLORRED,
        green:   ::LegoNXT::LowLevel::SensorTypes::COLORGREEN,
        blue:    ::LegoNXT::LowLevel::SensorTypes::COLORBLUE,
        passive: ::LegoNXT::LowLevel::SensorTypes::COLORNONE
      }

      def initialize(color = nil)
        on_assignment do
          color(color) unless color.nil?
        end
      end

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

      def value
        (1..3).each do
          v = @brick.fetch_input_value(@port)
          return v unless v.nil?
          sleep 0.1
        end
        nil
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
