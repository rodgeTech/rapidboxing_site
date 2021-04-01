class AddScheduleToOrders < ActiveRecord::Migration[5.2]
  def change
    add_reference :orders, :schedule, foreign_key: true
  end
end
