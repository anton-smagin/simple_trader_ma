# frozen_string_literal: true

require 'trader_decision'

describe TraderDecision do
  subject { described_class.new }

  before do
    stub_const('TraderDecision::PAIRS', ['EUR_USD'])
    expect(subject).to receive(:ticks) { [1] }
    expect(MASignal).to receive(:new) { proc { signal } }
    expect(subject).to receive(signal).with(1, 'EUR_USD')
  end

  context '#calls buy method' do
    let(:signal) { :buy }
    it { subject.call }
  end

  context '#calls sell method' do
    let(:signal) { :sell }
    it { subject.call }
  end

  context '#calls wait method' do
    let(:signal) { :wait }
    it { subject.call }
  end
end
