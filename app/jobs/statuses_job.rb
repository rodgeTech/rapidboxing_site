class StatusesJob
  include SuckerPunch::Job

  def perform
    ActiveRecord::Base.connection_pool.with_connection do
      order = Order.find(order_id)
      StatusUpdateMailer.status_updated(order).deliver
    end
  end
end
