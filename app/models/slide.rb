# frozen_string_literal: true

class Slide < ApplicationRecord
  has_one :image, as: :imageable, dependent: :destroy

  validates :main_title, :sub_title, :link_text, :link_to, presence: true
end
