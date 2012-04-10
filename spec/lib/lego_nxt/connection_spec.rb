require 'spec_helper'
require 'lego_nxt/connection'

describe LEGONXT::Connection do
  subject { LEGONXT::Connection.new }
  after(:each) { subject.close }

  describe "#new" do
    it "does something" do
      requires_nxt
      LEGONXT::Connection.new.close
    end

    it "works twice" do
      requires_nxt
      LEGONXT::Connection.new.close
      LEGONXT::Connection.new.close
    end
  end

  describe ".send" do
    it "should beep" do
      requires_nxt
      subject.send_bits [0x80, 0x03, 0xf4, 0x01, 0xf4, 0x01].pack('C*')
    end
  end

  describe ".close" do
    it "does something" do
      requires_nxt
      subject.close
    end

    it "can be called twice with no ill effects" do
      requires_nxt
      subject.close
      subject.close
    end
  end
end
