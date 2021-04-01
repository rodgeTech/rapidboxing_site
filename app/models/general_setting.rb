# frozen_string_literal: true

# GeneralSettings Model
class GeneralSetting < Setting
  field :business_name, type: :string, default: 'Your Business Name'
  field :contact_email, type: :string
  field :host, default: 'http://example.com'
  field :phone, type: :string
  field :street, type: :string
  field :city, type: :string
end
