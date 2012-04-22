require "lego_nxt/types"
require "lego_nxt/constants"
require "lego_nxt/errors"

module LegoNXT
  # A mid-level API for talking to a LEGO NXT brick.
  class Brick
    # The connection object.
    #
    # @return [LegoNXT::UsbConnection, LegoNXT::SerialConnection]
    attr_reader :connection

    # @param [LegoNXT::UsbConnection, LegoNXT::SerialConnection] connection The connection object.
    def initialize connection
      @connection = connection
    end

    # Plays a tone.
    #
    # @param [Integer] frequency Range: 200-1400Hz
    # @param [Integer] duration in milliseconds (1/1000 of a second)
    def play_tone frequency, duration
      raise ArgumentError.new("Frequency must be between 200-1400Hz; got #{frequency}") if frequency < 200 || frequency > 1400
      transmit(
        DirectOps::NO_RESPONSE,
        DirectOps::PLAYTONE,
        word(frequency),
        word(duration)
      )
    end

    # The battery level.
    #
    # @return [Integer] The voltage in millivolts.
    def battery_level
      transceive(
        DirectOps::REQUIRE_RESPONSE,
        DirectOps::GETBATTERYLEVEL,
      ).unpack('S<')[0]
    end

    # A wrapper around the transmit function for the connection.
    #
    # @param [LegoNXT::Type] bits A list of bytes.
    # @return [nil]
    def transmit *bits
      connection.transmit(bits.map(&:byte_string).join(""))
    end

    # A wrapper around the transceive function for the connection.
    #
    # @param [LegoNXT::Type] bits A list of bytes.
    # @return [String] Bytes as returned by the connection object.
    def transceive *bits
      bitstring = bits.map(&:byte_string).join("")
      retval = connection.transceive bitstring
      # Check that it's a response bit.
      raise LegoNXT::BadResponseError unless retval[0] == "\x02"
      # Check that it's for this command.
      raise LegoNXT::BadResponseError unless retval[1] == bitstring[1]
      # Check that there is no error.
      # TODO: This should raise a specific error based on the status bit.
      raise LegoNXT::StatusError unless retval[2] == "\x00"
      return retval[3..-1]
    end

  end
end
