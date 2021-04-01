# frozen_string_literal: true

class Order < ApplicationRecord
  include Totalable

  include PgSearch
  pg_search_scope :search, against: %i[id name email address
                                       contact_number tracking_number]

  has_many :order_items, dependent: :destroy
  has_many :deposits, dependent: :destroy
  has_one :invoice, dependent: :destroy
  belongs_to :user, optional: true
  belongs_to :schedule, optional: true

  accepts_nested_attributes_for :order_items, allow_destroy: true

  validates :email, :contact_number, :name, :address, presence: true

  enum status: %i[pending confirmed order_arrived being_shipped arrived out_for_delivery]

  generate_public_uid column: :tracking_number,
                      generator: PublicUid::Generators::NumberRandom.new

  scope :unarchived, -> { where(archive: false) }
  scope :archived, -> { where(archive: true) }
  scope :active, -> { where(draft: false) }

  scope :today, -> { where(created_at: Time.zone.now.beginning_of_day..Time.zone.now.end_of_day) }
end
