require "highline/system_extensions"
require 'lego_nxt'

include HighLine::SystemExtensions
include LegoNXT::Notes

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

brick = LegoNXT::connect

while @char != 27
  @char = get_character

  if @char != nil
    case @char.chr
    when 'a'
      @note = F4
    when 'w'
      @note = Fs4
    when 's'
      @note = G4
    when 'e'
      @note = Af3
    when 'd'
      @note = A3
    when 'r'
      @note = Bf3
    when 'f'
      @note = B3
    when 'g'
      @note = C4
    when 'y'
      @note = Cs4
    when 'h'
      @note = D4
    when 'u'
      @note = Ef4
    when 'j'
      @note = E4
    when 'k'
      @note = F4
    when 'o'
      @note = Fs4
    when 'l'
      @note = G4
    when 'p'
      @note = Af4
    when ';'
      @note = A4
    when '['
      @note = Bf4
    when '\''
      @note = B4
    end

    brick.play_tone @note.to_i, 500
  end
end
