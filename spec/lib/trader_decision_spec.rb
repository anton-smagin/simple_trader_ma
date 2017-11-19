# frozen_string_literal: true

require 'trader_decision'

describe TraderDecision do
  subject { described_class.new }

  describe 'call' do

    before do
      stub_const('TraderDecision::PAIRS', ['EUR_USD'])
      expect(subject).to receive(:ticks) { [1] }
      expect(MASignal).to receive(:new) { proc { signal } }
      expect(MASignal).to receive(:new) { proc { previous_signal } }
      expect(subject).to receive(send_signal).with(1, 'EUR_USD')
    end

    context '#calls buy method' do
      let(:signal) { :buy }
      let(:send_signal) { :buy }
      let(:previous_signal) { :wait }
      it { subject.call }
    end

    context '#calls sell method' do
      let(:signal) { :sell }
      let(:send_signal) { :sell }
      let(:previous_signal) { :wait }
      it { subject.call }
    end

    context '#calls wait method' do
      let(:signal) { :wait }
      let(:send_signal) { :wait }
      let(:previous_signal) { :wait }
      it { subject.call }
    end

    context 'skip buy trading if previous signal wasn`t wait' do
      let(:signal) { :buy }
      let(:previous_signal) { :buy }
      let(:send_signal) { :wait }
      it { subject.call }
    end

    context 'skip sell trading if previous signal wasn`t wait' do
      let(:signal) { :sell }
      let(:previous_signal) { :sell }
      let(:send_signal) { :wait }
      it { subject.call }
    end
  end
end
