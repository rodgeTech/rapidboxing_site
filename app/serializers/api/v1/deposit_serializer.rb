# frozen_string_literal: true

class Api::V1::DepositSerializer
  include FastJsonapi::ObjectSerializer

  set_type :deposit

  attributes :id, :status, :recorded_by_id

  belongs_to :recorded_by, record_type: :user, serializer: Api::V1::UserSerializer

  attribute :created_at do |object|
    object.created_at.strftime('%B %d, %Y')
  end

  attribute :amount do |object|
    object.amount.format
  end
end
