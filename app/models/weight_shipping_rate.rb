# frozen_string_literal: true

class WeightShippingRate < ShippingRate
  validates :min_order_weight, :max_order_weight, presence: true
  validates :min_order_weight, numericality: { greater_than: 0 }

  default_scope { order(min_order_weight: :asc) }

  def to_label
    "#{name} - (#{min_order_weight}lb  -  #{max_order_weight}lb) = #{rate_amount.format}"
  end
end
