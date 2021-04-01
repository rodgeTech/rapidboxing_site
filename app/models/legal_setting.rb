# frozen_string_literal: true

# LegalSettings Model
class LegalSetting < Setting
  field :refund_policy, type: :string
  field :shipping_policy, type: :string
  field :delivery_policy, type: :string
  field :privacy_policy, type: :string
  field :terms_of_service, type: :string
end
