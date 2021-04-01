# frozen_string_literal: true

class Api::V1::CartSerializer
  include FastJsonapi::ObjectSerializer

  set_type :cart

  attributes :id, :purchase_total, :estimated_total

  has_many :line_items

  attribute :purchase_total do |object|
    object.purchase_total.to_f
  end

  # attribute :shipping do |object|
  #   object.shipping.to_f
  # end

  attribute :estimated_total do |object|
    object.estimated_total.to_f
  end
end
