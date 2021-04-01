# frozen_string_literal: true

class User < ApplicationRecord
  include PgSearch
  pg_search_scope :search, against: %i[id name email]
  # Include default devise modules.
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  include DeviseTokenAuth::Concerns::User

  has_many :orders, dependent: :destroy
  has_many :invoices, dependent: :destroy
  has_one :cart, dependent: :destroy

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  generate_public_uid generator: PublicUid::Generators::NumberRandom.new

  validates :name, presence: true

  scope :not_admin, -> { where(admin: false) }
  scope :admin, -> { where(admin: true) }
  scope :confirmed, -> { where.not(confirmed_at: nil) }
  scope :pending, -> { where(invitation_accepted_at: nil) }

  def send_devise_notification(notification, *args)
    devise_mailer.send(notification, self, *args).deliver_later
  end

  def active_orders
    orders.where(draft: false)
  end
end
