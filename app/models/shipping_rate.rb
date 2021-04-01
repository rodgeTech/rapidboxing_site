# frozen_string_literal: true

class ShippingRate < ApplicationRecord
  monetize :min_order_price_cents, :max_order_price_cents, :rate_amount_cents

  validates :name, :rate_amount, presence: true, unless: :free_shipping
  validates :rate_amount, unless: :free_shipping, numericality: { greater_than: 0 }
end
