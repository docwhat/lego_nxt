require 'lego_nxt/low_level'
require 'lego_nxt/errors'
require 'lego_nxt/motor_port'
require 'lego_nxt/sensor_port'
require 'music/note'

module LegoNXT
  # An Object that represents a Lego NXT Brick
  class Brick
    attr_writer :note_class
    attr_reader :port_a, :port_b, :port_c, :port_1, :port_2, :port_3, :port_4

    DURATIONS = {
      whole:     3200,
      half:      1600,
      quarter:   800,
      eighth:    400,
      sixteenth: 200
    }

    # Add dotted items
    DURATIONS.keys.each { |k| DURATIONS["dotted_#{k}".to_sym] = (DURATIONS[k] * 1.5).to_i }

    # Add Strings
    DURATIONS.keys.each { |k| DURATIONS[k.to_s] = DURATIONS[k] }

    %w{a b c}.each do |p|
      define_method "port_#{p}=".to_sym do |port_object|
        if port_object.respond_to?(:assign_brick_and_motor_port)
          port_object.assign_brick_and_motor_port(self, p.to_sym)
          instance_variable_set("@port_#{p}", port_object)
        else
          fail InvalidPortObject, "This isn't suitable MotorPort: #{port_object.inspect}"
        end
      end
    end

    (1..4).each do |p|
      define_method "port_#{p}=".to_sym do |port_object|
        if port_object.respond_to?(:assign_brick_and_sensor_port)
          port_object.assign_brick_and_sensor_port(self, p)
          instance_variable_set("@port_#{p}", port_object)
        else
          fail InvalidPortObject, "This isn't suitable SensorPort: #{port_object.inspect}"
        end
      end
    end

    def initialize(brick_connection = nil)
      @brick_connection = brick_connection.nil? ? LegoNXT::LowLevel.connect : brick_connection
    end

    def note_class
      @note_class ||= Music::Note
    end

    def note_to_frequency(note)
      note_class.new(note).frequency
    end

    def wait(duration)
      ms = DURATIONS.fetch(duration, duration)
      Kernel.sleep(ms.to_f / 1000)
    end

    def play(note, duration = 500)
      ms = DURATIONS.fetch(duration, duration)
      note_ms = (ms * 0.9).to_i
      @brick_connection
        .play_tone(note_to_frequency(note), note_ms)
      wait(ms)
    end

    def input_value(port, type, mode)
      @brick_connection.transmit(
        ::LegoNXT::LowLevel::DirectOps::NO_RESPONSE,
        ::LegoNXT::LowLevel::DirectOps::SETINPUTMODE,
        port_id_to_byte(port),
        type,
        mode
      )
    end

    private

    def port_id_to_byte(port_id)
      {
        1  => byte(0),
        2  => byte(1),
        3  => byte(2),
        4  => byte(3),
        :a => byte(0),
        :b => byte(1),
        :c => byte(2)
      }.fetch(port_id, :error)
    end
  end
end
