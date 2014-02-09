# encoding: utf-8
require 'spec_helper'
require 'lego_nxt/low_level/usb_connection'
require 'lego_nxt/low_level/constants'

describe LegoNXT::LowLevel::UsbConnection, :integration, :needs_nxt do
  subject { described_class.new }
  after(:each) { subject.close }

  describe '#new' do
    it 'does something' do
      described_class.new.close
    end

    it 'works twice' do
      described_class.new.close
      described_class.new.close
    end
  end

  describe '.transmit' do
    it 'should beep' do
      ops = bytestring(LegoNXT::LowLevel::DirectOps::NO_RESPONSE,
                       LegoNXT::LowLevel::DirectOps::PLAYTONE,
                       uword(500),
                       uword(500))
      subject.transmit ops
      sleep 0.5
    end

    it 'return success' do
      ops = bytestring(LegoNXT::LowLevel::DirectOps::NO_RESPONSE,
                       LegoNXT::LowLevel::DirectOps::PLAYTONE,
                       uword(700),
                       uword(500))
      subject.transmit(ops).should be_true
      sleep 0.5
    end

    it "doesn't accept a REQUIRE_RESPONSE system command" do
      ops = bytestring LegoNXT::LowLevel::SystemOps::REQUIRE_RESPONSE
      expect { subject.transmit(ops) }.to raise_error(LegoNXT::BadOpCodeError)
    end

    it "doesn't accept a REQUIRE_RESPONSE direct command" do
      ops = bytestring LegoNXT::LowLevel::DirectOps::REQUIRE_RESPONSE
      expect { subject.transmit(ops) }.to raise_error(LegoNXT::BadOpCodeError)
    end
  end

  describe '.transceive' do
    context 'with a successful transmit' do
      let(:ops) do
        bytestring(
          LegoNXT::LowLevel::SystemOps::REQUIRE_RESPONSE,
          LegoNXT::LowLevel::SystemOps::GET_FIRMWARE_VERSION
        )
      end
      let(:retval) { subject.transceive(ops).unpack('C*') }

      it 'should return 7 bytes' do
        retval.should have(7).items
      end

      it 'should return the response bits' do
        retval[0].should eq(0x02)
        retval[1].should eq(0x88)
      end

      it 'should be successful' do
        retval[2].should eq(0x0)
      end
    end

    it "doesn't accept a NO_RESPONSE system command" do
      ops = bytestring LegoNXT::LowLevel::SystemOps::NO_RESPONSE
      expect { subject.transceive(ops) }.to raise_error(LegoNXT::BadOpCodeError)
    end

    it "doesn't accept a NO_RESPONSE direct command" do
      ops = bytestring LegoNXT::LowLevel::DirectOps::NO_RESPONSE
      expect { subject.transceive(ops) }.to raise_error(LegoNXT::BadOpCodeError)
    end

    context 'with an unsuccessful transmit' do
      it 'should raise TransmitError' do
        described_class.any_instance.stub(:open)
        subject.stub(:transmit!) { false }
        ops = bytestring LegoNXT::LowLevel::DirectOps::REQUIRE_RESPONSE
        expect { subject.transceive(ops) }.to raise_error(LegoNXT::TransmitError)
      end
    end
  end

  describe '.close' do
    it 'does something' do
      subject.close
    end

    it 'can be called twice with no ill effects' do
      subject.close
      subject.close
    end
  end
end
