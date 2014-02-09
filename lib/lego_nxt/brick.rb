require 'lego_nxt/low_level'
require 'music/note'

module LegoNXT
  # An Object that represents a Lego NXT Brick
  class Brick
    attr_writer :note_class

    def initialize(brick_connection = nil)
      @brick_connection = brick_connection.nil? ? LegoNXT::LowLevel.connect : brick_connection
    end

    def note_class
      @note_class ||= Music::Note
    end

    def note_to_frequency(note)
      note_class.new(note).frequency
    end

    def play(note, duration = 500)
      @brick_connection.play_tone(note_to_frequency(note), duration)
    end
  end
end
