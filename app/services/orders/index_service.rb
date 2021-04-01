# frozen_string_literal: true

module Orders
  class IndexService < BaseService
    def initialize(page:, per:, status:, date_sort:, query:)
      @page = page
      @per = per
      @status = status
      @date_sort = date_sort || :desc
      @query = query
    end

    def call
      validate_params?
      @orders = filter_by_status
      @orders = searched_orders
      @orders = sort_by_date
      paginated_orders
    end

    def validate_params?
      raise ArgumentError unless valid_pagination? &&
                                 valid_status? && valid_date?
    end

    def valid_pagination?
      @page.present? && @per.present? && @page.to_i >= 1 && @per.to_i >= 1
    end

    def valid_status?
      return true unless @status

      Order.statuses.keys.include?(@status) ||
        %i[archived cancelled].include?(@status.to_sym)
    end

    def valid_date?
      return true unless @date_sort

      %i[asc desc].include?(@date_sort.to_sym)
    end

    def filter_by_status
      return Order.active.unarchived unless @status.present?

      Order.active.unarchived.where(status: @status) if @status.present?
    end

    def searched_orders
      return @orders.search(@query) if @query.present?

      @orders
    end

    def sort_by_date
      return @orders.order(created_at: @date_sort) if @date_sort.present?

      @orders
    end

    def paginated_orders
      @orders
        .page(@page)
        .per(@per)
    end
  end
end
