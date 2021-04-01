# frozen_string_literal: true

module Api
  module V1
    class CalculatorsController < BaseController
      skip_before_action :authenticate_user!

      def show
        result = Calculator::CalculateService.call(params[:price],
                                                   params[:quantity],
                                                   params[:shipping_rate_id],
                                                   params[:extra_pounds],
                                                   params[:local_pickup])

        render json: result
      end
    end
  end
end
