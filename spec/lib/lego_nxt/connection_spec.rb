require 'spec_helper'
require 'lego_nxt/connection'

describe LegoNXT::Connection do
  subject { LegoNXT::Connection.new }
  after(:each) { HAS_NXT and subject.close }

  describe "#new" do
    it "does something" do
      needs_nxt do
        LegoNXT::Connection.new.close
      end
    end

    it "works twice" do
      needs_nxt do
        LegoNXT::Connection.new.close
        LegoNXT::Connection.new.close
      end
    end
  end

  describe ".transmit" do
    it "should beep" do
      needs_nxt do
        subject.transmit [0x80, 0x03, 0xf4, 0x01, 0xf4, 0x01].pack('C*')
      end
    end

    it "return success" do
      needs_nxt do
        subject.transmit([0x80, 0x03, 0xf4, 0x01, 0xf4, 0x01].pack('C*')).should be_true
      end
    end
  end

  describe ".transceive" do
    context "with a successful transmit" do
      let (:retval) { subject.transceive([0x01, 0x88].pack('C*')).unpack('C*') }
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
        LegoNXT::Connection.any_instance.stub(:open)
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
