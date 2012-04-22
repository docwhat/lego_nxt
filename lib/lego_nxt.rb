require "lego_nxt/version"
require "lego_nxt/brick"
require "lego_nxt/usb_connection"

# {LegoNXT} is a library for working with the LEGO NXT bricks.
module LegoNXT
end

# A helper method that attempt to attach to a brick and
# returns a {LegoNXT::Brick object}.
#
# @return [LegoNXT::Brick]
def LegoNXT::connect
  @found_connection ||= LegoNXT::UsbConnection.new
  LegoNXT::Brick.new @found_connection
end
