# frozen_string_literal: true

require 'moving_average'
# moving average signal
class MASignal
  attr_reader :ticks, :slow_m_a, :fast_m_a

  def call(ticks:, fast_m_a:, slow_m_a:)
    @ticks = ticks
    @fast_m_a = fast_m_a
    @slow_m_a = slow_m_a
    @elements_number = ticks.size - 1
    signal_changed? ? signal(ticks) : :wait
  end

  def signal(ticks)
    fast_average(ticks) > slow_average(ticks) ? :buy : :sell
  end

  def previous_ticks
    ticks[0...-1]
  end

  def signal_changed?
    signal(ticks) != signal(previous_ticks)
  end

  def slow_average(ticks)
    ticks.sma(ticks.size - 1, slow_m_a)
  end

  def fast_average(ticks)
    ticks.sma(ticks.size - 1, fast_m_a)
  end
end
