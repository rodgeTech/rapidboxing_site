# frozen_string_literal: true

class AddPublicUidToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :public_uid, :integer
    add_index  :users, :public_uid
  end
end
