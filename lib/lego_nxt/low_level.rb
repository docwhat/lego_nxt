require 'lego_nxt/low_level/types'
require 'lego_nxt/low_level/constants'
require 'lego_nxt/low_level/brick'
require 'lego_nxt/low_level/usb_connection'

module LegoNXT
  # A module of all the low level operations.
  module LowLevel
    # A helper method that attempt to attach to a brick and
    # returns a {LegoNXT::LowLevel::Brick object}.
    #
    # @return [LegoNXT::LowLevel::Brick]
    def self.connect
      @found_connection ||= UsbConnection.new
      Brick.new @found_connection
    end

    def self.disconnect
      unless @found_connection.nil?
        @found_connection.close
        @found_connection = nil
      end
    end
  end
end
