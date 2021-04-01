# frozen_string_literal: true

class InvoiceItem < ApplicationRecord
  include Priceable

  belongs_to :invoice
  belongs_to :order_item

  monetize :total_cents
end
