# frozen_string_literal: true

class Api::V1::WeightShippingRateSerializer
  include FastJsonapi::ObjectSerializer

  set_type :weight_shipping_rate

  attributes :id, :name, :min_order_weight, :max_order_weight, :free_shipping

  attribute :rate_amount do |object|
    object.rate_amount.format
  end

  attribute :amount do |object|
    object.rate_amount.to_f
  end
end
