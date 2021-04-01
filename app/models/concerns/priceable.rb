# frozen_string_literal: true

module Priceable
  extend ActiveSupport::Concern

  included do
    belongs_to :shipping_rate, optional: true
    monetize :price_cents
  end

  def total
    (price.to_f * quantity * RateSetting.exchange_rate.to_f).round(2)
  end

  def shipping_total
    total = (shipping_rate.rate_amount.to_f * quantity) * RateSetting.exchange_rate.to_f
    total += additional_pounds_total
    total
  end

  def flat_shipping_total
    (shipping_rate.rate_amount.to_f * quantity) * RateSetting.exchange_rate.to_f
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
    return 0.0 unless RateSetting.insurance

    (total * (RateSetting.insurance.to_f / 100)).round(2)
  end

  def additional_pounds_total
    return 0 if extra_pounds.nil? || extra_pounds.zero?

    (extra_pounds * RateSetting.additional_pounds.to_f * RateSetting.exchange_rate.to_f).to_f
  end

  def local_pickup_total
    return 0 unless local_pickup

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
