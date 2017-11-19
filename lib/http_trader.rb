class HttpTrader
  URL = 'https://api-fxpractice.oanda.com'.freeze
  TICKS_COUNT = 55
  TIME_FRAME = 'H1'.freeze
  UNITS = 5000

  def ticks(instrument, to = 1.minute.ago.utc)
    response = request_ticks(instrument, to)
    return Rails.logger.error response['errorMessage'] if response['errorMessage']
    response['candles'].select{|c| c['complete']}
                       .map{|c| c['mid']['c'].to_f}
  end

  def request_ticks(instrument, to = 1.minute.ago.utc)
    JSON.parse(HTTParty.get("#{URL}/v3/instruments/#{instrument}/candles",
                              query: {
                                count: TICKS_COUNT,
                                granularity: TIME_FRAME,
                                to: to.rfc3339
                              },
                              headers: headers
                           ).body)
  end

  def make_order(side:, stop_loss:, take_profit:, instrument:)
    units = side == 'buy' ? UNITS : "-#{UNITS}"
    response = HTTParty.post("#{URL}/v3/accounts/#{ENV['ACCOUNT']}/orders",
                             headers: headers,
                             body: {
                               order:{
                                 type: 'MARKET',
                                 instrument: instrument,
                                 stopLossOnFill: {price: stop_loss.to_s[0..6]},
                                 takeProfitOnFill: {price: take_profit.to_s[0..6]},
                                 units: units
                               }}.to_json)
    OrdersResponse.create(response: JSON.parse(response.body))
    JSON.parse(response.body)
  end

  def my_orders
    JSON.parse(HTTParty.get("#{URL}/v3/accounts/#{ENV['ACCOUNT']}/orders", headers: headers).body)
  end

  def my_accounts
    JSON.parse(HTTParty.get("#{URL}/v3/accounts", headers: headers).body)
  end

  def headers
    { 'Authorization' => "Bearer #{ENV['BEARER']}",
      'Content-Type' => 'application/json' }
  end
end
