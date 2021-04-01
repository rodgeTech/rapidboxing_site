# frozen_string_literal: true

class Api::V1::UserSerializer
  include FastJsonapi::ObjectSerializer

  set_type :user

  attributes :id, :name, :email
end
