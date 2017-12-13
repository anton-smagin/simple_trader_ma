class OrdersResponse < ApplicationRecord
  serialize :response, JSON

  scope :instrument, ->(instrument) { where("response like '%#{instrument}%'") }
end
