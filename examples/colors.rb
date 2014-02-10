# encoding: utf-8
#
# Shows colors via the NXT 2.0 Color Sensor
#
# The light sensor must be on port 1
require 'lego_nxt'
require 'ap'

brick = LegoNXT::Brick.new
color_sensor = LegoNXT::Sensors::ColorSensor.new
brick.port_1 = color_sensor

colors = [
  :full,
  :red,
  :green,
  :blue
]

(colors + colors).shuffle.each do |color|
  puts "Setting color to #{color}"
  color_sensor.color color
  (1..5).each do |i|
    sleep(i.to_f / 10)
    ap color_sensor.value
  end
end

# Turns it off
color_sensor.color :passive
