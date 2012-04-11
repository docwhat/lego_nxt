require 'libusb'
require 'lego_nxt/errors'

module LegoNXT

  # Low-level connection object for communicating with the NXT brick.
  #
  # It's interface is very simple. Higher levels of abstractions provide
  # access to opcodes, etc.
  #
  class Connection
    # The USB idVendor code
    LEGO_VENDOR_ID = 0x0694
    # The USB idProduct code
    NXT_PRODUCT_ID = 0x0002

    # The USB endpoint (communication channel) to send data out to the NXT brick
    USB_ENDPOINT_OUT = 0x01

    # The USB endpoint (communication channel) to receive data from the NXT brick
    USB_ENDPOINT_IN  = 0x82

    # Creates a connection to the NXT brick.
    #
    def initialize
      open
    end

    # Sends a packed string of bits.
    #
    # Example:
    #
    #     # Causes the brick to beep
    #     conn.send_bits [0x80, 0x03, 0xf4, 0x01, 0xf4, 0x01].pack('C*')'
    #
    # @see The LEGO MINDSTORMS NXT Communications Protocol (Appendex 1 of the Bluetooth Development Kit)
    #
    # @param {String} bits This must be a binary string. Use `Array#pack('C*')` to generate the string.
    # @return [Boolean] Returns true if all the data was sent and received by the NXT.
    def transmit bits
      bytes_sent = @handle.bulk_transfer dataOut: bits, endpoint: USB_ENDPOINT_OUT
      bytes_sent == bits.length
    end

    # Closes the connection
    #
    # @return [nil]
    def close
      return if @handle.nil?
      @handle.close
      @handle = nil
    end


    private

    # Opens the connection
    #
    # This is triggered automatically by intantiating the object.
    #
    # @return [nil]
    def open
      context = LIBUSB::Context.new
      device = context.devices(:idVendor => LEGO_VENDOR_ID, :idProduct => NXT_PRODUCT_ID).first
      raise NoDeviceError.new("Please make sure the device is plugged in and powered on") if device.nil?
      @handle = device.open
      @handle.claim_interface(0)
    end
  end
end
