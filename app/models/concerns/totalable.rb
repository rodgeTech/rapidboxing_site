# frozen_string_literal: true

module Totalable
  extend ActiveSupport::Concern

  def balance
    return total unless deposits.present?

    current_balance = total
    deposits.each do |deposit|
      current_balance -= deposit.amount.to_f
    end
    current_balance.round(2)
  end

  def total
    total = 0.0

    order_items.each do |order_item|
      total += order_item.overall_total
    end

    total.round(2)
  end

  def initial_deposit
    (total * (RateSetting.initial_deposit.to_f / 100)).ceil
  end

  def purchase_total
    total = 0.0

    order_items.each do |order_item|
      total += order_item.total
    end

    total.round(2)
  end

  def duty
    total = 0.0

    order_items.each do |order_item|
      total += order_item.duty_total
    end

    total.round(2)
  end

  def fees_total
    total = 0.0

    order_items.each do |order_item|
      total += order_item.fees_total
    end

    total.round(2)
  end

  def flat_shipping
    total = 0.0

    order_items.each do |order_item|
      total += order_item.flat_shipping_total
    end

    total.round(2)
  end

  def shipping
    total = 0.0

    order_items.each do |order_item|
      total += order_item.shipping_total
    end

    total.round(2)
  end

  def tax
    total = 0.0

    order_items.each do |order_item|
      total += order_item.tax_total
    end

    total.round(2)
  end

  def service_charge
    total = 0.0

    order_items.each do |order_item|
      total += order_item.service_charge_total
    end

    total.round(2)
  end

  def insurance_total
    return 0.0 unless RateSetting.insurance

    total = 0.0

    order_items.each do |order_item|
      total += order_item.insurance_total
    end

    total.round(2)
  end

  def additional_pounds_total
    total = 0.0

    order_items.each do |order_item|
      total += order_item.additional_pounds_total
    end

    total.round(2)
  end

  def local_pickup_total
    total = 0.0

    order_items.each do |order_item|
      total += order_item.local_pickup_total
    end

    total.round(2)
  end
end
