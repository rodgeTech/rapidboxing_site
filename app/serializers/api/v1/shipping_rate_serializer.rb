# frozen_string_literal: true

class Api::V1::ShippingRateSerializer
  include FastJsonapi::ObjectSerializer

  set_type :shipping_rate

  attributes :id, :name, :free_shipping, :min_order_weight, :max_order_weight

  attribute :rate_amount do |object|
    object.rate_amount.format
  end

  attribute :min_order_price do |object|
    object.min_order_price.format
  end

  attribute :max_order_price do |object|
    object.max_order_price.format
  end

  attribute :shipping_rate_type do |object|
    object.type.underscore
  end
end
