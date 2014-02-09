require 'io/console'
require 'lego_nxt/low_level'

include LegoNXT::LowLevel::Notes

puts
puts "Play your LEGO piano with your keyboard! (esc to quit)"
puts
puts " ___________________________________________ "
puts "|   w   e   r       y   u       o   p   [   |"
puts "|   _   _   _       _   _       _   _   _   |"
puts "|  | | | | | |  |  | | | |  |  | | | | | |  |"
puts "|  | | | | | |  |  | | | |  |  | | | | | |  |"
puts "|  |_| |_| |_|  |  |_| |_|  |  |_| |_| |_|  |"
puts "|   |   |   |   |   |   |   |   |   |   |   |"
puts "| F | G | A | B | C | D | E | F | G | A | B |"
puts "|___|___|___|___|___|___|___|___|___|___|___|"
puts "  a   s   d   f   g   h   j   k   l   ;   '  "
puts

brick = LegoNXT::LowLevel::connect

key_pressed = STDIN.getch
while key_pressed != "\e"
  case key_pressed
  when 'a'
    note_to_play = F4
  when 'w'
    note_to_play = Fs4
  when 's'
    note_to_play = G4
  when 'e'
    note_to_play = Af3
  when 'd'
    note_to_play = A3
  when 'r'
    note_to_play = Bf3
  when 'f'
    note_to_play = B3
  when 'g'
    note_to_play = C4
  when 'y'
    note_to_play = Cs4
  when 'h'
    note_to_play = D4
  when 'u'
    note_to_play = Ef4
  when 'j'
    note_to_play = E4
  when 'k'
    note_to_play = F4
  when 'o'
    note_to_play = Fs4
  when 'l'
    note_to_play = G4
  when 'p'
    note_to_play = Af4
  when ';'
    note_to_play = A4
  when '['
    note_to_play = Bf4
  when "'"
    note_to_play = B4
  else
    note_to_play = nil
  end

  brick.play_tone note_to_play.to_i, 500 unless note_to_play.nil?
  key_pressed = STDIN.getch
end

LegoNXT::disconnect
