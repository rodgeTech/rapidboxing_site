class AddInvoiceEmailedAtToOrders < ActiveRecord::Migration[5.2]
  def change
    add_column :orders, :invoice_emailed_at, :datetime
  end
end
