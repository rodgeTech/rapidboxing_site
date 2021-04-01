# frozen_string_literal: true

class Api::V1::ImageSerializer
  include FastJsonapi::ObjectSerializer

  set_type :image

  attributes :id

  attribute :image_url, &:image_url
end
