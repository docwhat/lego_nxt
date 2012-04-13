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
    REQUIRE_RESPONSE                                      = 0x00
    # The first byte sent when sending a direct command
    # and you don't want a response.
    NO_RESPONSE                                           = 0x80

    STARTPROGRAM                                          = 0x00
    STOPPROGRAM                                           = 0x01
    PLAYSOUNDFILE                                         = 0x02
    # Play a tone (beep)
    #
    # Arguments:
    #
    # 1. 2 bytes (UWORD) - Frequency in Hz (200 - 1400Hz)
    # 2. 2 bytes (UWORD) - Duration of the tone in ms.
    PLAYTONE                                              = 0x03
    SETOUTPUTSTATE                                        = 0x04
    SETINPUTMODE                                          = 0x05
    GETOUTPUTSTATE                                        = 0x06
    GETINPUTVALUES                                        = 0x07
    RESETINPUTSCALEDVALUE                                 = 0x08
    MESSAGEWRITE                                          = 0x09
    RESETMOTORPOSITION                                    = 0x0A

    # Get the battery Level
    #
    # Response:
    #
    # 1. 2 bytes (UWORD) - Voltage in millivolts.
    GETBATTERYLEVEL                                       = 0x0B
    STOPSOUNDPLAYBACK                                     = 0x0C
    KEEPALIVE                                             = 0x0D
    LSGETSTATUS                                           = 0x0E
    LSWRITE                                               = 0x0F
    LSREAD                                                = 0x10
    GETCURRENTPROGRAMNAME                                 = 0x11
    MESSAGEREAD                                           = 0x12
  end

  # Errors that may be return via the status-byte
  # for direct commands.
  module DirectOpsErrors
    PENDING_COMMUNICATION_TRANSACTION_IN_PROGRESS_ERROR       = 0x20
    SPECIFIED_MAILBOX_QUEUE_IS_EMPTY_ERROR                    = 0x40
    REQUEST_FAILED_ERROR                                      = 0xBD
    UNKNOWN_COMMAND_OPCODE_ERROR                              = 0xBE
    INSANE_PACKET_ERROR                                       = 0xBF
    DATA_CONTAINS_OUT_OF_RANGE_VALUES_ERROR                   = 0xC0
    COMMUNICATION_BUS_ERROR                                   = 0xDD
    NO_FREE_MEMORY_IN_COMMUNICATION_BUFFER_ERROR              = 0xDE
    SPECIFIED_CHANNEL_CONNECTION_IS_NOT_VALID_ERROR           = 0xDF
    SPECIFIED_CHANNEL_CONNECTION_NOT_CONFIGURED_OR_BUSY_ERROR = 0xE0
    NO_ACTIVE_PROGRAM_ERROR                                   = 0xEC
    ILLEGAL_SIZE_SPECIFIED_ERROR                              = 0xED
    ILLEGAL_MAILBOX_QUEUE_ID_SPECIFIED_ERROR                  = 0xEE
    ATTEMPTED_TO_ACCESS_INVALID_FIELD_OF_A_STRUCTURE_ERROR    = 0xEF
    BAD_INPUT_OR_OUTPUT_SPECIFIED_ERROR                       = 0xF0
    INSUFFICIENT_MEMORY_AVAILABLE_ERROR                       = 0xFB
    BAD_ARGUMENTS_ERROR                                       = 0xFF
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
    REQUIRE_RESPONSE                                    = 0x01
    # The first byte used when sending a system command
    # and you don't want a response.
    NO_RESPONSE                                         = 0x81

    OPEN_READ_COMMAND                                   = 0x80
    OPEN_WRITE_COMMAND                                  = 0x81
    READ_COMMAND                                        = 0x82
    WRITE_COMMAND                                       = 0x83
    CLOSE_COMMAND                                       = 0x84
    DELETE_COMMAND                                      = 0x85
    FIND_FIRST                                          = 0x86
    FIND_NEXT                                           = 0x87
    GET_FIRMWARE_VERSION                                = 0x88
    OPEN_WRITE_LINEAR_COMMAND                           = 0x89
    OPEN_READ_LINEAR_COMMAND_INTERNAL                   = 0x8A
    OPEN_WRITE_DATA_COMMAND                             = 0x8B
    OPEN_APPEND_DATA_COMMAND                            = 0x8C
    BOOT_COMMAND                                        = 0x97
    SET_BRICK_NAME_COMMAND                              = 0x98
    GET_DEVICE_INFO                                     = 0x9B
    DELETE_USER_FLASH                                   = 0xA0
    POLL_COMMAND_LENGTH                                 = 0xA1
    POLL_COMMAND                                        = 0xA2
    BLUETOOTH_FACTOR_RESET_COMMAND                      = 0xA4 # Don't send via bluetooth, duh.
  end

  # Errors that may be return via the status-byte
  # for system commands.
  module SystemOpsErrors
    NO_MORE_HANDLES_ERROR                               = 0x81
    NO_SPACE_ERROR                                      = 0x82
    NO_MORE_FILES_ERROR                                 = 0x83
    END_OF_FILE_EXPECTED_ERROR                          = 0x84
    END_OF_FILE_ERROR                                   = 0x85
    NOT_A_LINEAR_FILE_ERROR                             = 0x86
    FILE_NOT_FOUND_ERROR                                = 0x87
    HANDLE_ALL_READY_CLOSED_ERROR                       = 0x88
    NO_LINEAR_SPACE_ERROR                               = 0x89
    UNDEFINED_ERROR                                     = 0x8A
    FILE_IS_BUSY_ERROR                                  = 0x8B
    NO_WRITE_BUFFERS_ERROR                              = 0x8C
    APPEND_NOT_POSSIBLE_ERROR                           = 0x8D
    FILE_IS_FULL_ERROR                                  = 0x8E
    FILE_EXISTS_ERROR                                   = 0x8F
    MODULE_NOT_FOUND_ERROR                              = 0x90
    OUT_OF_BOUNDARY_ERROR                               = 0x91
    ILLEGAL_FILE_NAME_ERROR                             = 0x92
    ILLEGAL_HANDLE_ERROR                                = 0x93
  end
end
