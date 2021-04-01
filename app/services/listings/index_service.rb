# frozen_string_literal: true

module Listings
  class IndexService < BaseService
    def initialize(page:, per:, query:)
      @page = page
      @per = per
      @query = query
    end

    def call
      validate_params?
      @listings = searched_listings
      paginated_listings
    end

    def validate_params?
      raise ArgumentError unless valid_pagination?
    end

    def valid_pagination?
      @page.present? && @per.present? && @page.to_i >= 1 && @per.to_i >= 1
    end

    def searched_listings
      return Listing.search(@query) if @query.present?

      Listing.order(created_at: :desc)
    end

    def paginated_listings
      @listings
        .page(@page)
        .per(@per)
    end
  end
end
