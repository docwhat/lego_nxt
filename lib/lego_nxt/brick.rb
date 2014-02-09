require 'lego_nxt/low_level'
require 'music/note'

module LegoNXT
  # An Object that represents a Lego NXT Brick
  class Brick
    attr_writer :note_class

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
      puts "NARF #{note} #{duration} #{ms}"
      note_ms = (ms * 0.9).to_i
      @brick_connection
        .play_tone(note_to_frequency(note), note_ms)
      wait(ms)
    end
  end
end
