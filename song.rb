$LOAD_PATH.unshift('./lib').uniq!

require 'lego_nxt/usb_connection'
require 'lego_nxt/constants'

@subject = LegoNXT::UsbConnection.new

notes = %w(659 587 523 587 659 659 659 587 587 587 659 784 784 659 587 523 587 659 659 659 659 587 587 659 587)
notes_with_sleep = [[659, 0.5], [587, 0.5], [523, 0.5], [587, 0.5], [659, 0.5], [659, 0.5], [659, 1.0], [587, 0.5], [587, 0.5], [587, 1.0]]

def play(note, duration = 500, sleep = 0.5)
  ops = [LegoNXT::DirectOps::NO_RESPONSE,
    LegoNXT::DirectOps::PLAYTONE,
    note,
    duration].pack('CCvv')
  @subject.transmit ops
end

def play_song(song)
  song.each do |note_sleep|
    if note_sleep[0]
      play(note_sleep[0].to_i)
      sleep(note_sleep[1])
    else
      sleep(note_sleep[1])
    end
  end
  @subject.close
end

module One
  C = 261.6
  C_SH = 277.2
  D = 293.7
  E_FL = 311.1
  E = 329.6
  F = 349.2
  F_SH = 370
  G = 392
  G_SH = 415.3
  A = 440
  B_FL = 466.2
  B = 493.9
end

module Two
  C = 523.3
  C_SH = 554.4
  D = 587.3
  E_FL = 622.3
  E = 659.3
  F = 698.5
  F_SH = 740
  G = 784
  G_SH = 830.6
  A = 880
  B_FL = 932.3
  B = 987.8
end

@test = [One::E]

@ode_to_joy = [
  One::E,
  One::E, 
  One::F, 
  One::G, 
  One::G, 
  One::F, 
  One::E, 
  One::D, 
  One::C, 
  One::C, 
  One::D, 
  One::E, 
  One::E, 
  One::D, 
  One::D
]

@ode_to_joy2 = [
  Two::E,
  Two::E, 
  Two::F, 
  Two::G, 
  Two::G, 
  Two::F, 
  Two::E, 
  Two::D, 
  Two::C, 
  Two::C, 
  Two::D, 
  Two::E, 
  Two::E, 
  Two::D, 
  Two::D,
  nil,
  Two::E,
  Two::E,
  Two::F,
  Two::G,
  Two::G,
  Two::F,
  Two::E,
  Two::D,
  Two::C,
  Two::C,
  Two::D,
  Two::E,
  Two::D,
  Two::C,
  Two::C
]

@test_song = [
  One::C,
  One::C,
  One::C
]

# play_song(@ode_to_joy.map { |note| [note, 0.5] })
# play_song(@ode_to_joy2.map { |note| [note, 0.4] })
play_song(@test_song.map { |note| [note, 0.5] })

def play_note(key)
  case key
  when "a"
    puts 'd'
    play(One::D)
  when "w"
    puts 'eb'
    play(One::E_FL)
  when "s"
    puts 'e'
    play(One::E)
  when "d"
    puts 'f'
    play(One::F)
  when "r"
    puts 'f#'
    play(One::F_SH)
  when "f"
    puts 'g'
    play(One::G)
  when "t"
    puts 'g#'
    play(One::G_SH)
  when "g"
    puts 'a'
    play(One::A)
  when "y"
    puts 'bb'
    play(One::B_FL)
  when "h"
    puts 'b'
    play(One::B)
  when "j"
    puts 'c'
    play(Two::C)
  when "i"
    puts 'c#'
    play(Two::C_SH)
  when "k"
    puts 'd'
    play(Two::D)
  when "i"
    puts 'eb'
    play(Two::E_FL)
  when "l"
    puts 'e'
    play(Two::E)
  when ";"
    puts 'f'
    play(Two::F)
  when "["
    puts 'f#'
    play(Two::F_SH)
  when "'"
    puts 'g'
    play(Two::G)
  when "]"
    puts 'g#'
    play(Two::G_SH)
  end
end

# @key = nil
# while @key != 'q'
  # @key = gets.chomp
  # if @key && @key != 'q'
    # play_note(@key)
  # end
# end

# system("stty raw -echo")
# @key = nil
# while @key != 'q'
#   @key = STDIN.getc
#   if @key && @key != 'q'
#     play_note(@key)
#     puts
#   end
# end

@subject.close
