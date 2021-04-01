# frozen_string_literal: true

class Schedule < ApplicationRecord
  has_many :orders, dependent: :destroy

  validates :departure, :arrival, presence: true, uniqueness: true
  validate :departure_after_arrival

  scope :adjacent, -> { where('departure >= ?', Date.today).order(departure: :asc).first }
  scope :upcoming, -> { where('departure >= ?', Date.today).order(departure: :asc) }

  private

  def departure_after_arrival
    return if departure.blank? || arrival.blank?

    if arrival <= departure
      errors.add(:arrival, 'must be after the departure date')
    end
  end
end
