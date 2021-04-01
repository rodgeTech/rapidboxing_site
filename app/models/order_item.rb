# frozen_string_literal: true

class OrderItem < ApplicationRecord
  include Priceable

  belongs_to :order
  has_one :invoice_item, dependent: :destroy
end
