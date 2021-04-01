# frozen_string_literal: true

class Listing < ApplicationRecord
  include PgSearch
  pg_search_scope :search, against: %i[title description link]

  extend FriendlyId
  friendly_id :title, use: :slugged

  belongs_to :shipping_rate
  has_many :images, as: :imageable, dependent: :destroy

  validates :title, :link, presence: true
  validates :link, url: true

  monetize :price_cents

  accepts_nested_attributes_for :images, allow_destroy: true
end
