module LEGONXT
  # All LEGONXT errors are subclassed from this
  # error class.
  class LEGONXTError < StandardError
  end

  # No NXT bricks were found.
  class NoDeviceError < LEGONXTError
  end
end
