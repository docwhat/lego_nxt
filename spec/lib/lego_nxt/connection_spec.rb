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
