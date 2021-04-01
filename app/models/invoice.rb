# frozen_string_literal: true

class Invoice < ApplicationRecord
  belongs_to :order
  belongs_to :user, optional: true
  has_many :invoice_items, dependent: :destroy

  accepts_nested_attributes_for :invoice_items

  monetize :sub_total_cents
  monetize :shipping_fee_cents
  monetize :delivery_fee_cents
  monetize :service_charge_cents
  monetize :sales_tax_cents
  monetize :discount_cents
  monetize :balance_cents

  generate_public_uid generator: PublicUid::Generators::NumberRandom.new
end
