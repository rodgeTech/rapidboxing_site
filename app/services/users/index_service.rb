# frozen_string_literal: true

module Users
  class IndexService < BaseService
    def initialize(page:, per:, date_sort:, query:)
      @page = page
      @per = per
      @date_sort = date_sort || :desc
      @query = query
    end

    def call
      validate_params?
      @users = searched_users
      @users = sort_by_date
      paginated_users
    end

    def validate_params?
      raise ArgumentError unless valid_pagination? && valid_date?
    end

    def valid_pagination?
      @page.present? && @per.present? && @page.to_i >= 1 && @per.to_i >= 1
    end

    def valid_date?
      return true unless @date_sort

      %i[asc desc].include?(@date_sort.to_sym)
    end

    def searched_users
      return User.not_admin.confirmed.search(@query) if @query.present?

      User.not_admin.confirmed
    end

    def sort_by_date
      return @users.order(created_at: @date_sort) if @date_sort.present?

      @users
    end

    def paginated_users
      @users
        .page(@page)
        .per(@per)
    end
  end
end
