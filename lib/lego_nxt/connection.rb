require 'libusb'
require 'lego_nxt/errors'

module LEGONXT

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
      @mutex = Mutex.new
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
    # @param {String} bits This must be a binary string. Use `Array#pack` to generate the string.
    # @return [nil]
    def send_bits bits
      @handle.bulk_transfer dataOut: bits, endpoint: USB_ENDPOINT_OUT
      nil
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
      @mutex.synchronize do
        context = LIBUSB::Context.new
        device = context.devices(:idVendor => LEGO_VENDOR_ID, :idProduct => NXT_PRODUCT_ID).first
        raise LEGONXT::NoDeviceError("Please make sure the device is plugged in and powered on") if device.nil?
        @handle = device.open
        @handle.claim_interface(0)
      end
    end
  end
end
