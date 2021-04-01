class OrdersJob
  include SuckerPunch::Job

  def perform(order_id)
    ActiveRecord::Base.connection_pool.with_connection do
      order = Order.find(order_id)
      OrderMailer.new_order(order).deliver
    end
  end
end
