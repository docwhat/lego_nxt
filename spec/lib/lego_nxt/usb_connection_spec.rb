require 'spec_helper'
require 'lego_nxt/usb_connection'
require 'lego_nxt/constants'

describe LegoNXT::UsbConnection do
  subject { LegoNXT::UsbConnection.new }
  after(:each) { HAS_NXT and subject.close }

  describe "#new" do
    it "does something" do
      needs_nxt do
        LegoNXT::UsbConnection.new.close
      end
    end

    it "works twice" do
      needs_nxt do
        LegoNXT::UsbConnection.new.close
        LegoNXT::UsbConnection.new.close
      end
    end
  end

  describe ".transmit" do
    it "should beep" do
      needs_nxt do
        ops = [LegoNXT::DirectOps::NO_RESPONSE,
               LegoNXT::DirectOps::PLAYTONE,
               500,
               500].pack('CCvv')
        subject.transmit ops
        sleep 0.5
      end
    end

    it "return success" do
      needs_nxt do
        ops = [LegoNXT::DirectOps::NO_RESPONSE,
               LegoNXT::DirectOps::PLAYTONE,
               700,
               500].pack('CCvv')
        subject.transmit(ops).should be_true
        sleep 0.5
      end
    end
  end

  describe ".transceive" do
    context "with a successful transmit" do
      let (:ops) do
        [LegoNXT::SystemOps::REQUIRE_RESPONSE,
         LegoNXT::SystemOps::GET_FIRMWARE_VERSION].pack 'CC'
      end
      let (:retval) { subject.transceive(ops).unpack('C*') }
      it "should return 7 bytes" do
        needs_nxt do
          retval.should have(7).items
        end
      end

      it "should return the response bits" do
        needs_nxt do
          retval[0].should == 0x02
          retval[1].should == 0x88
        end
      end

      it "should be successful" do
        needs_nxt do
          retval[2].should == 0x0
        end
      end
    end

    context "with an unsuccessful transmit" do
      it "should raise TransmitError" do
        LegoNXT::UsbConnection.any_instance.stub(:open)
        subject.stub(:transmit) { false }
        expect { subject.transceive(double) }.to raise_error(LegoNXT::TransmitError)
      end
    end
  end

  describe ".close" do
    it "does something" do
      needs_nxt do
        subject.close
      end
    end

    it "can be called twice with no ill effects" do
      needs_nxt do
        subject.close
        subject.close
      end
    end
  end
end
