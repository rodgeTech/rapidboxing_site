# frozen_string_literal: true

CarrierWave.configure do |config|
  if Rails.env.staging? || Rails.env.production?
    config.fog_credentials = {
      provider: 'AWS',
      region: 'us-east-1',
      aws_access_key_id: ENV['AWS_ACCESS_KEY_ID'],
      aws_secret_access_key: ENV['AWS_SECRET_ACCESS_KEY'],
    }
    config.fog_directory = ENV['S3_BUCKET']
    config.storage = :fog
  else
    config.storage = :file
    config.asset_host = 'http://localhost:3000'
  end
end
