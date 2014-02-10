require 'spec_helper'
require 'lego_nxt/motors/base'

describe LegoNXT::Motors::Base do
  subject(:motor) { described_class.new }

  describe '#assign_brick_and_motor_port' do
    let(:brick)       { instance_double('LegoNXT::Brick') }
    let(:port_symbol) { [:a, :b, :c].sample }

    it 'assigns the brick' do
      subject.assign_brick_and_motor_port(brick, port_symbol)
      subject.brick.should eq(brick)
    end

    it 'assigns the port' do
      subject.assign_brick_and_motor_port(brick, port_symbol)
      subject.port.should eq(port_symbol)
    end
  end
end
