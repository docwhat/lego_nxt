# encoding: utf-8

require 'lego_nxt/low_level'
require "lego_nxt/low_level/types"

module LegoNXT::LowLevel
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

  # Sensor Types (for SETINPUTMODE)
  module SensorTypes
    NO_SENSOR          = byte(0x00)
    SWITCH             = byte(0x01)
    TEMPERATURE        = byte(0x02)
    REFLECTION         = byte(0x03)
    ANGLE              = byte(0x04)
    LIGHT_ACTIVE       = byte(0x05)
    LIGHT_INACTIVE     = byte(0x06)
    SOUND_DB           = byte(0x07)
    SOUND_DBA          = byte(0x08)
    CUSTOM             = byte(0x09)
    LOWSPEED           = byte(0x0A)
    LOWSPEED_9V        = byte(0x0B)
    NO_OF_SENSOR_TYPES = byte(0x0C)
    COLORFULL          = byte(0x0D)
    COLORRED           = byte(0x0E)
    COLORGREEN         = byte(0x0F)
    COLORBLUE          = byte(0x10)
    COLORNONE          = byte(0x11)
  end

  # Sensor Modes (for SETINPUTMODE)
  module SensorModes
    RAWMODE           = byte(0x00)
    BOOLEANMODE       = byte(0x20)
    TRANSITIONCNTMODE = byte(0x40)
    PERIODCOUNTERMODE = byte(0x60)
    PCTFULLSCALEMODE  = byte(0x80)
    CELSIUSMODE       = byte(0xA0)
    FAHRENHEITMODE    = byte(0xC0)
    ANGLESTEPSMODE    = byte(0xE0)
    SLOPEMASK         = byte(0x1F)
    MODEMASK          = byte(0xE0)
  end

  # Notes for playing music.
  module Notes
    N34 = 1396.91
    N33 = 1318.51
    N32 = 1244.51
    N31 = 1174.66
    N30 = 1108.73
    N29 = 1046.5
    N28 = 987.767
    N27 = 932.328
    N26 = 880
    N25 = 830.609
    N24 = 783.991
    N23 = 739.989
    N22 = 698.456
    N21 = 659.255
    N20 = 622.254
    N19 = 587.33
    N18 = 554.365
    N17 = 523.251
    N16 = 493.883
    N15 = 466.164
    N14 = 440
    N13 = 415.305
    N12 = 391.995
    N11 = 369.994
    N10 = 349.228
    N9  = 329.628
    N8  = 311.127
    N7  = 293.665
    N6  = 277.183
    N5  = 261.626
    N4  = 246.942
    N3  = 233.082
    N2  = 220
    N1  = 207.652

    F6  = 1396.91
    E6  = 1318.51
    Ef6 = 1244.51
    Ds6 = Ef6
    D6  = 1174.66
    Df6 = 1108.73
    Cs6 = Df6
    C6  = 1046.5
    B5  = 987.767
    Bf5 = 932.328
    As5 = Bf5
    A5  = 880
    Af5 = 830.609
    Gs5 = Af5
    G5  = 783.991
    Gf5 = 739.989
    Fs5 = Gf5
    F5  = 698.456
    E5  = 659.255
    Ef5 = 622.254
    Ds5 = Ef5
    D5  = 587.33
    Df5 = 554.365
    Cs5 = Df5
    C5  = 523.251
    B4  = 493.883
    Bf4 = 466.164
    As4 = Bf4
    A4  = 440
    Af4 = 415.305
    Gs4 = Af4
    G4  = 391.995
    Gf4 = 369.994
    Fs4 = Gf4
    F4  = 349.228
    E4  = 329.628
    Ef4 = 311.127
    Ds4 = Ef4
    D4  = 293.665
    Df4 = 277.183
    Cs4 = Df4
    C4  = 261.626
    B3  = 246.942
    Bf3 = 233.082
    As3 = Bf3
    A3  = 220
    Af3 = 207.652
    Gs3 = Af3
  end
end