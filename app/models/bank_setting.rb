# frozen_string_literal: true

# BankSettings Model
class BankSetting < Setting
  field :belize_bank, type: :string
  field :belize_bank_account_name, type: :string
  field :atlantic_bank, type: :string
  field :atlantic_bank_account_name, type: :string
  field :scotia_bank, type: :string
  field :scotia_bank_account_name, type: :string
  field :heritage_bank, type: :string
  field :heritage_bank_account_name, type: :string
end
