# frozen_string_literal: true

class Api::V1::ListingSerializer
  include FastJsonapi::ObjectSerializer

  set_type :listing

  attributes :id, :title, :description, :link, :requirements, :shipping_rate_id

  has_many :images
  belongs_to :shipping_rate

  attribute :cover_image do |object|
    if object.images.any?
      object.images.last.image_url
    else
      'http://d1x1aywlanwpqv.cloudfront.net/hedjint/store/noimage.png'
    end
  end

  attribute :price do |object|
    object.price.to_f
  end
end
