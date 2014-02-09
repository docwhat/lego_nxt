require 'io/console'
require 'lego_nxt/low_level'
require 'music/note'

puts
puts 'Play your LEGO piano with your keyboard! (esc to quit)'
puts
puts ' ___________________________________________ '
puts '|   w   e   r       y   u       o   p   [   |'
puts '|   _   _   _       _   _       _   _   _   |'
puts '|  | | | | | |  |  | | | |  |  | | | | | |  |'
puts '|  | | | | | |  |  | | | |  |  | | | | | |  |'
puts '|  |_| |_| |_|  |  |_| |_|  |  |_| |_| |_|  |'
puts '|   |   |   |   |   |   |   |   |   |   |   |'
puts '| F | G | A | B | C | D | E | F | G | A | B |'
puts '|___|___|___|___|___|___|___|___|___|___|___|'
puts "  a   s   d   f   g   h   j   k   l   ;   '  "
puts

brick = LegoNXT::LowLevel.connect

QWERTY_MAP = {
  'a' => 'F4',
  'w' => 'F#4',
  's' => 'G4',
  'e' => 'G#3',
  'd' => 'A3',
  'r' => 'A#3',
  'f' => 'B3',
  'g' => 'C4',
  'y' => 'C#4',
  'h' => 'D4',
  'u' => 'D#4',
  'j' => 'E4',
  'k' => 'F4',
  'o' => 'F#4',
  'l' => 'G4',
  'p' => 'G#4',
  ';' => 'A4',
  '[' => 'A#4',
  "'" => 'B4'
}

key_pressed = STDIN.getch
while key_pressed != "\e"
  note_to_play = QWERTY_MAP.fetch(key_pressed, nil)

  brick.play_tone Music::Note.new(note_to_play).frequency, 500 unless note_to_play.nil?
  key_pressed = STDIN.getch
end
