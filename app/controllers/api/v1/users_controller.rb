# frozen_string_literal: true

module Api
  module V1
    class UsersController < BaseController
      def index
        @users = Users::IndexService.call(
          page: params[:page] || 1,
          per: params[:per] || 6,
          date_sort: :desc,
          query: params[:query]
        )

        render json: UserSerializer.new(@users).serialized_json
      end
    end
  end
end
