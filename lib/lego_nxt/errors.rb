module LegoNXT
  # All LegoNXT errors are subclassed from this
  # error class.
  class LegoNXTError < StandardError
  end

  # No NXT bricks were found.
  class NoDeviceError < LegoNXTError
  end
end
