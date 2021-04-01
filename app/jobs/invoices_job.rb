class InvoicesJob
  include SuckerPunch::Job

  def perform(invoice_id)
    ActiveRecord::Base.connection_pool.with_connection do
      invoice = Invoice.find(invoice_id)
      InvoiceMailer.new_invoice(invoice).deliver
    end
  end
end
