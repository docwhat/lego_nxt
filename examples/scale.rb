# encoding: utf-8
# Plays a quick scale.

require 'lego_nxt'

brick = LegoNXT::Brick.new

%w{C4, D4, E4, F4, G4, A4, B4, C5}.map(&:to_sym).each do |note|
  brick.play_tone note
end
