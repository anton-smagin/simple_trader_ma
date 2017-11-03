class RenameResponeTable < ActiveRecord::Migration[5.1]
  def change
    rename_table :orders_respones, :orders_responses
  end
end
