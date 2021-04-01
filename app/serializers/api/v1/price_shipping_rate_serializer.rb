# frozen_string_literal: true

class Api::V1::PriceShippingRateSerializer
  include FastJsonapi::ObjectSerializer

  set_type :price_shipping_rate

  attributes :id, :name, :free_shipping

  attribute :min_order_price do |object|
    object.min_order_price.format
  end

  attribute :max_order_price do |object|
    object.max_order_price.format
  end

  attribute :rate_amount do |object|
    object.rate_amount.format
  end
end
