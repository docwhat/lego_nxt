# encoding: utf-8
#
# Reads the light sensor for 10 seconds.
#
# The light sensor must be on port 1
require 'lego_nxt/low_level'
require 'ap'

brick = LegoNXT::LowLevel::connect

count = 20
(1..count).each do |i|
  puts "Check: #{i}/#{count}"
  sleep 0.5
  ap brick.light_sensor(1)
end
