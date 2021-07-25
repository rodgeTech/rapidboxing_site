# frozen_string_literal: true

class LineItem < ApplicationRecord
  include Priceable

  belongs_to :listing, optional: true
  belongs_to :cart
  has_many :images, as: :imageable, dependent: :destroy


  validates :quantity, :link, presence: true
  validates :price, presence: true, format: { with: /\A\d+(?:\.\d{2})?\z/ },
                    numericality: { greater_than: 0, less_than: 1_000_000 }
end
