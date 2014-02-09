# encoding: utf-8
# Plays a quick scale.

require 'lego_nxt'
require 'ap'

brick = LegoNXT::Brick.new

[
  %w{E5 sixteenth},
  %w{E5 eighth},
  %w{E5 sixteenth},
  %w{-  sixteenth},
  %w{C5 sixteenth},
  %w{E5 eighth},
  %w{G5 quarter},
  %w{G4 quarter},

  %w{C5 eighth},
  %w{-  sixteenth},
  %w{G5 sixteenth},
  %w{-  eighth},
  %w{E5 eighth},
  %w{-  sixteenth},
  %w{A5 sixteenth},
  %w{-  sixteenth},
  %w{B5 sixteenth},
  %w{-  sixteenth},
  %w{Bb5 sixteenth},
  %w{A5 eighth}
].each do |note, duration|
  if '-' == note
    brick.wait duration
  else
    brick.play note, duration
  end
end
