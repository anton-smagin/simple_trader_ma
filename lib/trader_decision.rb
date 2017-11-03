# frozen_string_literal: true

require 'm_a_signal'
require 'http_trader'
# class that makes deals
class TraderDecision
  PAIRS = %w[EUR_USD GBP_USD AUD_USD USD_JPY USD_CAD].freeze

  SLOWMA = 50
  FASTMA = 15

  STOPLOSS = 0.0002
  TAKEPROFIT = 0.0004

  def call
    PAIRS.each do |pair|
      pair_ticks = ticks(pair)
      signal = MASignal.new.call(ticks: pair_ticks, slow_m_a: SLOWMA, fast_m_a: FASTMA)
      send(signal, pair_ticks.last)
    end
  end

  def ticks(instrument)
    http_trader.ticks(instrument)
  end

  def buy(price)
    execute(side: 'buy', stop_loss: (price - price * STOPLOSS), take_profit:(price + price * TAKEPROFIT))
  end

  def sell(price)
    execute(side: 'sell', stop_loss: (price + price * STOPLOSS), take_profit:(price - price * TAKEPROFIT))
  end

  def wait(price)
    # do nothing
  end

  def execute(side:, stop_loss:, take_profit:, instrument:)
    http_trader.make_order(side: side, stop_loss: stop_loss, take_profit: take_profit, instrument: instrument)
  end

  def http_trader
    @trader ||= HttpTrader.new
  end
end
