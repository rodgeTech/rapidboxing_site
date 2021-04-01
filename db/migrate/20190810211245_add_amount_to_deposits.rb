# frozen_string_literal: true

class AddAmountToDeposits < ActiveRecord::Migration[5.2]
  def change
    add_monetize :deposits, :amount
  end
end
