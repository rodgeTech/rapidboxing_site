# frozen_string_literal: true

# ShippingSettings Model
class ShippingSetting < Setting
  # weight, price, disabled
  field :rate_method, type: :string, default: 'weight'

  attr_accessor :rate_method
end
