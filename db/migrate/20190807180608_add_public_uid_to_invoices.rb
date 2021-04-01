# frozen_string_literal: true

class AddPublicUidToInvoices < ActiveRecord::Migration[5.2]
  def change
    add_column :invoices, :public_uid, :integer
    add_index  :invoices, :public_uid
  end
end
