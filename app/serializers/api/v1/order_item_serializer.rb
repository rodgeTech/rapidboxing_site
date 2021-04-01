# frozen_string_literal: true

class Api::V1::OrderItemSerializer
  include FastJsonapi::ObjectSerializer

  set_type :order_item

  attributes :id, :link, :quantity, :details, :shipping_rate_id,
             :local_pickup

  belongs_to :shipping_rate

  attribute :price do |object|
    object.price.to_f.round(2)
  end

  attribute :price_usd do |object|
    object.total.to_f.round(2)
  end

  attribute :shipping_rate_name do |object|
    object.shipping_rate.name
  end

  attribute :shipping_rate_min do |object|
    object.shipping_rate.min_order_weight
  end

  attribute :shipping_rate_max do |object|
    object.shipping_rate.max_order_weight
  end

  attribute :shipping_rate_amount do |object|
    object.shipping_rate.rate_amount.format
  end

  attribute :tax, &:tax_total

  attribute :duty, &:duty_total

  attribute :service_charge, &:service_charge_total

  attribute :insurance, &:insurance_total

  attribute :local_pickup, &:local_pickup_total

  attribute :overall_total, &:overall_total

  attribute :flat_shipping_total, &:flat_shipping_total

  attribute :shipping_total, &:shipping_total

  attribute :additional_pounds_total, &:additional_pounds_total

  attribute :fees_total, &:fees_total

  attribute :extra_pounds do |object|
    object.extra_pounds.to_s.sub(/\.?0+$/, '')
  end

  # attribute :selected_shipping_rate do |object|
  #   object.price.to_f
  # end
end
