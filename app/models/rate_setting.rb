# frozen_string_literal: true

# RateSettings Model
class RateSetting < Setting
  field :initial_deposit, type: :decimal, default: 75
  field :tax, type: :decimal, default: 12.5
  field :duty_rate, type: :decimal, default: 38.5
  field :service_charge, type: :decimal, default: 14.5
  field :insurance, type: :decimal, default: 7.5
  field :exchange_rate, type: :float, default: 2
  field :pickup_fee, type: :decimal, default: 15
  field :additional_pounds, type: :float, default: 0.50
end
