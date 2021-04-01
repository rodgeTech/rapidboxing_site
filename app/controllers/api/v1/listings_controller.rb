# frozen_string_literal: true

module Api
  module V1
    class ListingsController < BaseController
      skip_before_action :authenticate_user!
      before_action :set_listing, only: :show

      def index
        @listings = Listings::IndexService.call(
          page: params[:page] || 1,
          per: params[:per] || 10,
          query: params[:query]
        )

        schedule = if Schedule.upcoming.any?
                     Schedule.upcoming.first.departure.strftime('%A, %b %o')
                   else
                     'Coming soon'
                   end

        options = {}
        options[:include] = %i[images]
        options[:is_collection] = true
        options[:meta] = { shipment_schedule: schedule }
        render json: ListingSerializer.new(@listings, options).serialized_json
      end

      def show
        options = {}
        options[:include] = [:images]
        options[:is_collection] = false
        render json: ListingSerializer.new(@listing, options).serialized_json
      end

      private

      def set_listing
        @listing = Listing.friendly.find(params[:id])
      end
    end
  end
end
