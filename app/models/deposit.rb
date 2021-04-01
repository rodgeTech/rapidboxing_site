# frozen_string_literal: true

class Deposit < ApplicationRecord
  belongs_to :order
  belongs_to :user, optional: true
  belongs_to :recorded_by, class_name: 'User'

  monetize :amount_cents

  enum status: %i[pending_approval approved]

  default_scope { order(created_at: :desc) }

  validate :deposit_amount

  def deposit_amount
    if amount.to_f > order.balance
      errors.add(:amount, "can't be greater than the order balance")
    end
  end
end
