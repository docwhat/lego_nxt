module LegoNXT
  # All LegoNXT errors are subclassed from this
  # error class.
  class LegoNXTError < StandardError; end

  # No NXT bricks were found.
  class NoDeviceError < LegoNXTError; end

  # The transmit failed for some reason
  class TransmitError < LegoNXTError; end

  # A bad response was received.
  class BadResponseError < LegoNXTError; end

  # An error was returned from the NXT via a status byte.
  class StatusError < LegoNXTError; end

  # A bad opcode was attempted to be sent.
  class BadOpCodeError < LegoNXTError; end
end
