# frozen_string_literal: true

module Admin
  module Settings
    class AccountsController < BaseController
      before_action :user, only: :resend
      before_action :user_from_invitation_token, only: :destroy

      def show
        @users = User.admin.order(created_at: :desc).where.not(id: current_user.id)
      end

      def new
        @user = User.new
      end

      def create
        @user = User.new(user_params)
        @user.admin = true
        @user.valid?
        @user.errors.messages.except!(:password)
        if @user.errors.any?
          render :new
        else
          @user.invite!
          redirect_to admin_settings_account_path,
                      flash: { notice: 'User has been invited' }
        end
      end

      def resend
        @user.invite!
        redirect_to admin_settings_account_path,
                    flash: { notice: 'Invitation sent' }
      end

      def destroy
        User.destroy(@user.id)
        flash[:success] = 'Invitation cancelled'
        redirect_to admin_settings_account_path
      end

      private

      def user_params
        params.require(:user).permit(:name, :email)
      end

      def user
        @user ||= User.find(params[:id])
      end

      def user_from_invitation_token
        unless params[:invitation_token] && @user = User.where(invitation_token: params[:invitation_token]).first
          flash[:error] = 'Invitation not found'
          redirect_to admin_settings_account_path
        end
      end
    end
  end
end
