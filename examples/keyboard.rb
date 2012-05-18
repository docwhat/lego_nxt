# Plays a quick scale.

require 'lego_nxt'
include LegoNXT::Notes

brick = LegoNXT::connect

# Notes constants are included with LegoNXT::Notes
[C4, D4, E4, F4, G4, A4, B4, C5].each do |note|
  # We don't handle fractions on the NXT.
  brick.play_tone note.to_i, 500
  # We have to sleep because we don't know when the note is done playing.
  sleep 0.6
end
