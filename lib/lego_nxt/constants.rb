# encoding: utf-8

require "lego_nxt/types"

module LegoNXT
  # op-codes for direct commands.
  #
  # All commands, when using {REQUIRE_RESPONSE} should
  # return: `0x02, <op-code>, <status-byte> [, <data-payload>...]`
  #
  # The status byte is either 0 for success, or one of the
  # constants below that end in `_ERROR`.
  #
  # For brevity, only the data-payload is documented.
  #
  # All strings should be null (`0x00`) terminated.
  #
  # See the LEGO MINDSTORMS NXT Bluetooth Developer Kit
  # Appendix 2 - LEGO MINDSTORMS NXT Direct commands
  module DirectOps
    # The first byte sent when sending a direct command
    # and you expect a response.
    REQUIRE_RESPONSE                                      = byte(0x00)
    # The first byte sent when sending a direct command
    # and you don't want a response.
    NO_RESPONSE                                           = byte(0x80)

    STARTPROGRAM                                          = byte(0x00)
    STOPPROGRAM                                           = byte(0x01)
    PLAYSOUNDFILE                                         = byte(0x02)
    # Play a tone (beep)
    #
    # Arguments:
    #
    # 1. 2 bytes (UWORD) - Frequency in Hz (200 - 1400Hz)
    # 2. 2 bytes (UWORD) - Duration of the tone in ms.
    PLAYTONE                                              = byte(0x03)
    SETOUTPUTSTATE                                        = byte(0x04)
    SETINPUTMODE                                          = byte(0x05)
    GETOUTPUTSTATE                                        = byte(0x06)
    GETINPUTVALUES                                        = byte(0x07)
    RESETINPUTSCALEDVALUE                                 = byte(0x08)
    MESSAGEWRITE                                          = byte(0x09)
    RESETMOTORPOSITION                                    = byte(0x0A)

    # Get the battery Level
    #
    # Response:
    #
    # 1. 2 bytes (UWORD) - Voltage in millivolts.
    GETBATTERYLEVEL                                       = byte(0x0B)
    STOPSOUNDPLAYBACK                                     = byte(0x0C)
    KEEPALIVE                                             = byte(0x0D)
    LSGETSTATUS                                           = byte(0x0E)
    LSWRITE                                               = byte(0x0F)
    LSREAD                                                = byte(0x10)
    GETCURRENTPROGRAMNAME                                 = byte(0x11)
    MESSAGEREAD                                           = byte(0x12)
  end

  # Errors that may be return via the status-byte
  # for direct commands.
  module DirectOpsErrors
    PENDING_COMMUNICATION_TRANSACTION_IN_PROGRESS_ERROR       = byte(0x20)
    SPECIFIED_MAILBOX_QUEUE_IS_EMPTY_ERROR                    = byte(0x40)
    REQUEST_FAILED_ERROR                                      = byte(0xBD)
    UNKNOWN_COMMAND_OPCODE_ERROR                              = byte(0xBE)
    INSANE_PACKET_ERROR                                       = byte(0xBF)
    DATA_CONTAINS_OUT_OF_RANGE_VALUES_ERROR                   = byte(0xC0)
    COMMUNICATION_BUS_ERROR                                   = byte(0xDD)
    NO_FREE_MEMORY_IN_COMMUNICATION_BUFFER_ERROR              = byte(0xDE)
    SPECIFIED_CHANNEL_CONNECTION_IS_NOT_VALID_ERROR           = byte(0xDF)
    SPECIFIED_CHANNEL_CONNECTION_NOT_CONFIGURED_OR_BUSY_ERROR = byte(0xE0)
    NO_ACTIVE_PROGRAM_ERROR                                   = byte(0xEC)
    ILLEGAL_SIZE_SPECIFIED_ERROR                              = byte(0xED)
    ILLEGAL_MAILBOX_QUEUE_ID_SPECIFIED_ERROR                  = byte(0xEE)
    ATTEMPTED_TO_ACCESS_INVALID_FIELD_OF_A_STRUCTURE_ERROR    = byte(0xEF)
    BAD_INPUT_OR_OUTPUT_SPECIFIED_ERROR                       = byte(0xF0)
    INSUFFICIENT_MEMORY_AVAILABLE_ERROR                       = byte(0xFB)
    BAD_ARGUMENTS_ERROR                                       = byte(0xFF)
  end

  # op-codes for system commands.
  #
  # All commands, when using {REQUIRE_RESPONSE} should
  # return: `0x02, <op-code>, <status-byte> [, <data-payload>...]`
  #
  # The status byte is either 0 for success, or one of the
  # constants below that end in `_ERROR`.
  #
  # For brevity, only the data-payload is documented.
  #
  # All strings should be null (`0x00`) terminated.
  #
  # See the LEGO MINDSTORMS NXT Bluetooth Developer Kit
  # Appendix 1 - LEGO MINDSTORMS NXT Communication protocol
  module SystemOps
    # The first byte used when sending a system command
    # and you expect a response.
    REQUIRE_RESPONSE                                    = byte(0x01)
    # The first byte used when sending a system command
    # and you don't want a response.
    NO_RESPONSE                                         = byte(0x81)

    OPEN_READ_COMMAND                                   = byte(0x80)
    OPEN_WRITE_COMMAND                                  = byte(0x81)
    READ_COMMAND                                        = byte(0x82)
    WRITE_COMMAND                                       = byte(0x83)
    CLOSE_COMMAND                                       = byte(0x84)
    DELETE_COMMAND                                      = byte(0x85)
    FIND_FIRST                                          = byte(0x86)
    FIND_NEXT                                           = byte(0x87)
    GET_FIRMWARE_VERSION                                = byte(0x88)
    OPEN_WRITE_LINEAR_COMMAND                           = byte(0x89)
    OPEN_READ_LINEAR_COMMAND_INTERNAL                   = byte(0x8A)
    OPEN_WRITE_DATA_COMMAND                             = byte(0x8B)
    OPEN_APPEND_DATA_COMMAND                            = byte(0x8C)
    BOOT_COMMAND                                        = byte(0x97)
    SET_BRICK_NAME_COMMAND                              = byte(0x98)
    GET_DEVICE_INFO                                     = byte(0x9B)
    DELETE_USER_FLASH                                   = byte(0xA0)
    POLL_COMMAND_LENGTH                                 = byte(0xA1)
    POLL_COMMAND                                        = byte(0xA2)
    BLUETOOTH_FACTORY_RESET_COMMAND                     = byte(0xA4) # Don't send via bluetooth, duh.
  end

  # Errors that may be return via the status-byte
  # for system commands.
  module SystemOpsErrors
    NO_MORE_HANDLES_ERROR                               = byte(0x81)
    NO_SPACE_ERROR                                      = byte(0x82)
    NO_MORE_FILES_ERROR                                 = byte(0x83)
    END_OF_FILE_EXPECTED_ERROR                          = byte(0x84)
    END_OF_FILE_ERROR                                   = byte(0x85)
    NOT_A_LINEAR_FILE_ERROR                             = byte(0x86)
    FILE_NOT_FOUND_ERROR                                = byte(0x87)
    HANDLE_ALL_READY_CLOSED_ERROR                       = byte(0x88)
    NO_LINEAR_SPACE_ERROR                               = byte(0x89)
    UNDEFINED_ERROR                                     = byte(0x8A)
    FILE_IS_BUSY_ERROR                                  = byte(0x8B)
    NO_WRITE_BUFFERS_ERROR                              = byte(0x8C)
    APPEND_NOT_POSSIBLE_ERROR                           = byte(0x8D)
    FILE_IS_FULL_ERROR                                  = byte(0x8E)
    FILE_EXISTS_ERROR                                   = byte(0x8F)
    MODULE_NOT_FOUND_ERROR                              = byte(0x90)
    OUT_OF_BOUNDARY_ERROR                               = byte(0x91)
    ILLEGAL_FILE_NAME_ERROR                             = byte(0x92)
    ILLEGAL_HANDLE_ERROR                                = byte(0x93)
  end
end
