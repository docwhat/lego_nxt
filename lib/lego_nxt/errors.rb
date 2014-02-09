# encoding: utf-8

module LegoNXT
  # All LegoNXT errors are subclassed from this
  # error class.
  class LegoNXTError < StandardError; end

  # The port object isn't the right kind.
  class InvalidPortObject < LegoNXTError; end

  # A base class for LowLevel errors.
  class LegoNXTLowLevelError < LegoNXTError; end

  # No NXT bricks were found.
  class NoDeviceError < LegoNXTLowLevelError; end

  # The transmit failed for some reason
  class TransmitError < LegoNXTLowLevelError; end

  # A bad response was received.
  class BadResponseError < LegoNXTLowLevelError; end

  # An error was returned from the NXT via a status byte.
  class StatusError < LegoNXTLowLevelError; end

  # A bad opcode was attempted to be sent.
  class BadOpCodeError < LegoNXTLowLevelError; end
end
