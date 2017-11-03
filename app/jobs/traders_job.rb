require 'trader_decision'
class TradersJob < ApplicationJob
  def perform
    TraderDecision.new.call
  end
end
