require 'spec_helper'
require 'lego_nxt/port'

describe LegoNXT::Port do
  subject(:port) { described_class.new }

  describe 'on_assignment' do
    let(:hooks) { [] }

    before { port.stub(:assignment_hooks).with.and_return(hooks) }

    it 'adds the block to hooks' do
      hooks.should have(0).items

      port.on_assignment { :block_contents }

      hooks.should have(1).items
    end
  end

  describe 'call_hooks' do
    let(:hooks) { [] }

    before { port.stub(:assignment_hooks).with.and_return(hooks) }

    it 'calls all blocks in the list of hooks' do
      (1..3).each do
        p = proc { :true }
        expect(p).to receive(:call).with(port)
        hooks << p
      end

      port.call_assignment_hooks

      hooks.should have(0).items
    end
  end
end
