# frozen_string_literal: true

module Api
  module V1
    class ImagesController < BaseController
      before_action :image, only: [:destroy]

      def destroy
        @image.destroy
        head :no_content
      end

      private

      def image
        @image ||= Image.find(params[:id])
      end
    end
  end
end
