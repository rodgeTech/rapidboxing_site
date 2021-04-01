# frozen_string_literal: true

module Admin
  class UsersController < BaseController
    before_action :user, only: %i[show destroy]

    def index
      @users = Users::IndexService.call(
        page: params[:page] || 1,
        per: 6,
        date_sort: params[:date],
        query: params[:query]
      )
    end

    def show
      @orders = @user.orders.order(created_at: :desc)
    end

    def destroy
      @user.destroy
      flash[:success] = 'User removed successfully'
      redirect_to admin_users_path
    end

    private

    def user
      @user ||= User.find(params[:id])
    end
  end
end
