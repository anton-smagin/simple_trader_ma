# frozen_string_literal: true

require_relative '../m_a_signal.rb'
#vlass that maes deals
class TraderDecision
  PAIRS = %w[EURUSD].freeze

  SLOWMA = 25
  FASTMA = 14

  def call
    MASignal.new.call(ticks: ticks, slow_m_a: SLOWMA, fast_m_a: FASTMA)
  end

  def ticks

  end
end
