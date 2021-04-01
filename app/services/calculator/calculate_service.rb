# frozen_string_literal: true

module Calculator
  class CalculateService
    attr_reader :price
    attr_reader :quantity
    attr_reader :shipping_rate
    attr_reader :extra_pounds
    attr_reader :local_pickup

    def initialize(price, quantity, shipping_rate_id,
                   extra_pounds, local_pickup)
      @price = price.to_f
      @quantity = quantity.to_f
      @shipping_rate = ShippingRate.find(shipping_rate_id)
      @extra_pounds = extra_pounds.to_f
      @local_pickup = local_pickup
    end

    def self.call(*args, &block)
      new(*args, &block).calculate
    end

    def calculate
      {
        bzd_total: total,
        usd_total: usd_total,
        overall_total: overall_total,
        flat_total: total,
        shipping_total: shipping_total,
        additional_pounds_total: additional_pounds_total,
        flat_shipping_total: flat_shipping_total,
        tax_total: tax_total,
        duty_total: duty_total,
        service_charge_total: service_charge_total,
        insurance_total: insurance_total,
        fees_total: fees_total,
        local_pickup_total: local_pickup_total,
        quantity: quantity,
        extra_pounds: extra_pounds
      }
    end

    private

    def usd_total
      (price * quantity).round(2)
    end

    def total
      (price * quantity * RateSetting.exchange_rate.to_f).round(2)
    end

    def shipping_total
      total = (shipping_rate.rate_amount.to_f * quantity) * RateSetting.exchange_rate.to_f
      total += additional_pounds_total
      total
    end

    def flat_shipping_total
      shipping_rate.rate_amount.to_f * quantity * RateSetting.exchange_rate.to_f
    end

    def additional_pounds_total
      return 0 if extra_pounds.nil? || extra_pounds.zero?

      (extra_pounds * RateSetting.additional_pounds.to_f * RateSetting.exchange_rate.to_f).to_f
    end

    def tax_total
      (total * RateSetting.tax.to_f / 100).round(2)
    end

    def duty_total
      (total * (RateSetting.duty_rate.to_f / 100)).round(2)
    end

    def service_charge_total
      (total * (RateSetting.service_charge.to_f / 100)).round(2)
    end

    def insurance_total
      if RateSetting.insurance
        return (total * RateSetting.insurance.to_f / 100).round(2)
      end

      0.0
    end

    def local_pickup_total
      return 0 unless local_pickup == 'true'

      RateSetting.pickup_fee * RateSetting.exchange_rate.to_f
    end

    def fees_total
      (local_pickup_total + tax_total + duty_total +
        service_charge_total + insurance_total).round(2)
    end

    def overall_total
      (total + shipping_total + local_pickup_total + tax_total + duty_total +
        service_charge_total + insurance_total).round(2)
    end
  end
end
