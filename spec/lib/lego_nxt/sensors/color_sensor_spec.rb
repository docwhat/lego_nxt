require 'spec_helper'
require 'lego_nxt/sensors/color_sensor'

describe LegoNXT::Sensors::ColorSensor do
  subject(:sensor) { described_class.new }

  describe '.new' do
    it 'takes an optional color' do
      color = described_class::COLORS.keys.sample

      sensor = described_class.new(color)

      expect(sensor)
        .to receive(:color)
        .with(color)

      sensor.call_assignment_hooks
    end
  end

  describe '#color' do
    it 'sets the input value' do
      color = described_class::COLORS.keys.sample
      color_byte = described_class::COLORS[color]

      expect(sensor)
        .to receive(:input_value)
        .with(color_byte)

      sensor.color(color)
    end

    context 'with an invalid color' do
      it 'raises an error' do
        expect { sensor.color(:not_a_color) }
          .to raise_error(ArgumentError)
      end
    end
  end

  describe '#off' do
    it 'calls color(:passive)' do
      expect(sensor)
        .to receive(:color)
        .with(:passive)

      sensor.off
    end
  end
end
