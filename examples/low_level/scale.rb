# encoding: utf-8
# Plays a quick scale.

require 'lego_nxt/low_level'
brick = LegoNXT::LowLevel::connect

C4 = 261.63
D4 = 293.66
E4 = 329.63
F4 = 349.23
G4 = 392.00
A4 = 440.00
B4 = 493.88
C5 = 523.25

[C4, D4, E4, F4, G4, A4, B4, C5].each do |note|
  # We don't handle fractions on the NXT.
  brick.play_tone note.to_i, 500
  # We have to sleep because we don't know when the note is done playing.
  sleep 0.6
end
