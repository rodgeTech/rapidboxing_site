# frozen_string_literal: true

class PriceShippingRate < ShippingRate
  validates :min_order_price, :max_order_price,
            numericality: { greater_than: 0 }

  def to_label
    "#{name} - (#{min_order_price.format}  -  #{max_order_price.format}) = #{rate_amount.format}"
  end
end
