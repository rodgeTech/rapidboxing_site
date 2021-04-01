class ReceiptsJob
  include SuckerPunch::Job

  def perform
    ActiveRecord::Base.connection_pool.with_connection do
      deposit = Deposit.find(deposit_id)
      ReceiptMailer.deposit_recorded(deposit).deliver
    end
  end
end
