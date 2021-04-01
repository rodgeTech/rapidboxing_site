# frozen_string_literal: true

class Cart < ApplicationRecord
  has_many :line_items, dependent: :destroy
  belongs_to :user, optional: true

  def estimation?
    if line_items.where(price_cents: 0).any? ||
       line_items.where(shipping_rate_id: nil).any?
      return false
    end

    true
  end

  def total_items
    line_items.count
  end

  def purchase_total
    total = 0.0

    line_items.each do |line_item|
      total += line_item.total
    end

    total.round(2)
  end

  def shipping
    total = 0.0

    line_items.each do |line_item|
      total += line_item.shipping
    end

    total.round(2)
  end

  def estimated_total
    total = 0.0

    line_items.each do |line_item|
      total += line_item.overall_total
    end

    total.round(2)
  end
end
