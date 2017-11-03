class CreateOrdersRespones < ActiveRecord::Migration[5.1]
  def change
    create_table :orders_respones do |t|
      t.text :response

      t.timestamps
    end
  end
end
