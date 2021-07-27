# frozen_string_literal: true

class Api::V1::LineItemSerializer
  include FastJsonapi::ObjectSerializer

  set_type :line_item

  attributes :id, :link, :quantity, :details, :price, :shipping_rate_id, :extra_pounds

  has_many :images

  attribute :price do |object|
    object.price.to_f
  end
end
