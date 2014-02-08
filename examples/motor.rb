# encoding: utf-8
# Runs the brick forwards, then backwards.
#
# It runs on all ports, so it doesn't matter which port you use.

brick = LegoNXT::connect

brick.run_motor :all
sleep 3
brick.run_motor :all, -100
sleep 3
brick.stop_motor :all
