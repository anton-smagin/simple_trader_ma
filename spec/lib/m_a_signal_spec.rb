# frozen_string_literal: true

require 'm_a_signal'

describe MASignal do
  let(:wait_signal) { (0..25).to_a  }
  let(:buy_signal) { (0..25).to_a.reverse << 100 }
  let(:sell_signal) { (0..25).to_a << -100 }
  context '#call' do
    it 'sends wait signal when signal doesn`t change' do
      expect(described_class.new.call(ticks: wait_signal, fast_m_a: 14, slow_m_a: 25)).to eq(:wait)
    end

    it 'sends sell signal when fast average lower then slow' do
      expect(described_class.new.call(ticks: sell_signal, fast_m_a: 14, slow_m_a: 25)).to eq(:sell)
    end

    it 'sends buy signal when fast average higher then slow' do
      expect(described_class.new.call(ticks: buy_signal, fast_m_a: 14, slow_m_a: 25)).to eq(:buy)
    end
  end
end
