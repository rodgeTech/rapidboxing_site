# frozen_string_literal: true

class Api::V1::InvoiceSerializer
  include FastJsonapi::ObjectSerializer

  set_type :invoice

  attributes :id, :public_uid

  attribute :created_at do |object|
    object.created_at.strftime('%B %d, %Y')
  end

  attribute :sub_total do |object|
    object.sub_total.format
  end

  attribute :shipping_fee do |object|
    object.shipping_fee.format
  end

  attribute :delivery_fee do |object|
    object.delivery_fee.format
  end

  attribute :service_charge do |object|
    object.service_charge.format
  end

  attribute :sales_tax do |object|
    object.sales_tax.format
  end

  attribute :discount do |object|
    object.discount.format
  end

  attribute :balance do |object|
    object.balance.format
  end
end
