require "spec_helper"
require "lego_nxt/brick"
require 'lego_nxt/constants'

describe LegoNXT::Brick  do
  let(:connection) do
    double(name: 'Connection').tap do |conn|
      conn.stub(:transmit)
      conn.stub(:transceive)
    end
  end
  subject { LegoNXT::Brick.new(connection) }

  describe "#new" do
    it "sets the connection property" do
      subject.connection.should == connection
    end
  end

  describe ".transmit" do
    it "should pass the message to the connection" do
      connection.should_receive(:transmit).with("\x42")
      subject.send(:transmit, byte(0x42))
    end
  end

  describe ".transceive" do
    it "should pass the message to the connection" do
      connection.should_receive(:transceive).with("\x80\x42") { "\x02\x42\x00" }
      subject.transceive byte(0x80), byte(0x42)
    end

    it "should strip off the first 3 bytes" do
      connection.stub(:transceive) { "\x02\x42\x00happy" }
      subject.transceive(byte(0x80), byte(0x42)).should == "happy"
    end

    it "should raise an error if it doesn't get a reply byte" do
      connection.stub(:transceive) { "\x03" }
      expect { subject.transceive(byte(0x20), byte(0x42)) }.to raise_error(LegoNXT::BadResponseError)
    end

    it "should raise an error if the op-code byte doesn't match" do
      connection.stub(:transceive) { "\x03\x43" }
      expect { subject.transceive(byte(0x20), byte(0x42)) }.to raise_error(LegoNXT::BadResponseError)
    end

    it "should raise an error if the status byte isn't zero" do
      connection.stub(:transceive) { "\x02\x42\x20" }
      expect { subject.transceive(byte(0x20), byte(0x42)) }.to raise_error(LegoNXT::StatusError)
    end
  end

  describe ".play_tone" do
    it "doesn't accept frequencies under 200" do
      expect { subject.play_tone 199, 400 }.to raise_error(ArgumentError)
    end

    it "doesn't accept frequencies over 1400" do
      expect { subject.play_tone 1401, 400 }.to raise_error(ArgumentError)
    end

    it "accepts a frequency of 200" do
      subject.play_tone 200, 400
    end

    it "accepts a frequency of 1400" do
      subject.play_tone 1400, 400
    end

    it "should transmit the correct info" do
      subject.should_receive(:transmit).with(
        LegoNXT::DirectOps::NO_RESPONSE,
        LegoNXT::DirectOps::PLAYTONE,
        uword(501),
        uword(502)
      )
      subject.play_tone 501, 502
    end
  end

  describe ".battery_level" do
    it "returns something" do
      connection.stub(:transceive) { bytestring 0x02, LegoNXT::DirectOps::GETBATTERYLEVEL, 0x00, uword(8184) }
      subject.battery_level.should == 8184
    end
  end

end
