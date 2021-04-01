# frozen_string_literal: true

class Api::V1::OrderSerializer
  include FastJsonapi::ObjectSerializer

  set_type :order

  attributes :id, :name, :contact_number, :email, :address, :status,
             :tracking_number, :user_id, :invoice_emailed_at, :archive

  has_many :order_items
  has_many :deposits
  has_one :invoice

  attribute :created_at do |object|
    object.created_at.strftime('%B %d, %Y')
  end

  attribute :status do |object|
    object.status.split('_').collect(&:capitalize).join(' ')
  end

  attribute :status_enum, &:status

  attribute :statuses do |_obj|
    statuses = []
    Order.statuses.keys.each do |status|
      statuses.push(status.split('_').collect(&:capitalize).join(' '))
    end
    statuses
  end

  attribute :statuses_enum do |_obj|
    Order.statuses.keys
  end

  attribute :balance, &:balance
  attribute :total, &:total
  attribute :purchase_total, &:purchase_total
  attribute :shipping, &:shipping
  attribute :fees_total, &:fees_total
  attribute :service_charge, &:service_charge
  attribute :duty, &:duty
  attribute :tax, &:tax
  attribute :initial_deposit, &:initial_deposit
end
