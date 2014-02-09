require 'spec_helper'
require 'lego_nxt/brick'

describe LegoNXT::Brick do
  subject(:brick) { described_class.new(brick_connection) }

  let(:brick_connection) { instance_double('LegoNXT::LowLevel::Brick', play_tone: nil) }

  describe '#play_tone' do
    let(:note)     { "C##{rand(3) + 2}" }
    let(:freq)     { rand(3) * 300 }
    let(:duration) { LegoNXT::Brick::DURATIONS.keys.sample }
    let(:ms)       { LegoNXT::Brick::DURATIONS[duration] }

    before do
      brick.stub(:note_to_frequency)
        .with(note)
        .and_return(freq)
      brick.stub(:wait)
    end

    it 'translates note symbols' do
      expect(brick)
        .to receive(:note_to_frequency)
        .with(note)
      brick.play note, duration
    end

    it 'calls LowLevel::Brick#send_tone' do
      expect(brick_connection)
        .to receive(:play_tone)
        .with(freq, (ms - (ms * 0.1)).to_i)
      brick.play note, duration
    end

    it 'calls wait' do
      expect(brick)
        .to receive(:wait)
        .with(ms)
      brick.play note, duration
    end
  end

  describe '#note_to_frequency' do
    let(:note_class)    { class_double('Music::Note', new: note_instance) }
    let(:note_instance) { instance_double('Music::Note', frequency: 'does not matter') }

    before do
      brick.note_class = note_class
    end

    it 'creates a new Note object' do
      note = 'C4'
      expect(note_class)
        .to receive(:new)
        .with(note)
      brick.note_to_frequency(note)
    end

    it 'gets the frequency from the object' do
      expect(note_instance)
        .to receive(:frequency)
        .with
      brick.note_to_frequency('does not matter')
    end
  end

  describe '#wait' do
    let(:duration) { LegoNXT::Brick::DURATIONS.keys.sample }
    let(:ms)       { LegoNXT::Brick::DURATIONS[duration] }

    it 'sleeps according to duration' do
      expect(Kernel)
        .to receive(:sleep)
        .with(ms.to_f / 1000)
      brick.wait duration
    end
  end
end
