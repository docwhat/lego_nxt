$LOAD_PATH.unshift('./lib').uniq!

require 'lego_nxt/usb_connection'
require 'lego_nxt/constants'

@subject = LegoNXT::UsbConnection.new

ops = [LegoNXT::DirectOps::NO_RESPONSE,
  LegoNXT::DirectOps::PLAYTONE,
  500,
  500].pack('CCvv')
@subject.transmit(ops)
@subject.close

@subject = LegoNXT::UsbConnection.new
@move_forward = [LegoNXT::DirectOps::NO_RESPONSE,
       LegoNXT::DirectOps::SETOUTPUTSTATE,
       0xFF, # output port
       100, # power set point
       0x01, # mode
       0x00, # regulation mode
       0, # turn ratio
       0x20, # run state
       0].pack('C*') #tacho limit

@move_backward = [LegoNXT::DirectOps::NO_RESPONSE,
       LegoNXT::DirectOps::SETOUTPUTSTATE,
       0xFF, # output port
       -100, # power set point
       0x01, # mode
       0x00, # regulation mode
       0, # turn ratio
       0x20, # run state
       0].pack('C*') #tacho limit


@stop = [LegoNXT::DirectOps::NO_RESPONSE,
       LegoNXT::DirectOps::SETOUTPUTSTATE,
       0xFF, # output port
       0, # power set point
       0x00, # mode
       0x00, # regulation mode
       0, # turn ratio
       0x00, # run state
       0].pack('C*') #tacho limit

def move(key)
  case key
  when "a"
    @subject.transmit(@move_forward)
  when "s"
    @subject.transmit(@move_backward)
  when "d"
    @subject.transmit(@stop)
  end
end

system("stty raw -echo")
@key = nil
while @key != 'q'
  @key = STDIN.getc
  if @key && @key != 'q'
    move(@key)
    puts
  end
end

system("stty raw -echo")
@subject.close
sleep 0.5
