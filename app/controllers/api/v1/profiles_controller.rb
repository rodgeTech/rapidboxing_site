# frozen_string_literal: true

module Api
  module V1
    class ProfilesController < BaseController
      def show
        options = {}
        options[:is_collection] = false
        render json: UserSerializer.new(current_user, options).serialized_json
      end
    end
  end
end
