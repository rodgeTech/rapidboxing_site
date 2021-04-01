# frozen_string_literal: true

module Api
  module V1
    class ContactsController < BaseController
      skip_before_action :authenticate_user!

      def create
        contact_form = ContactForm.new(contact_params)
        if contact_form.valid?
          contact_form.deliver
          head :ok
        else
          head :unprocessable_entity
        end
      end

      private

      def contact_params
        params.permit(:name, :email, :message)
      end
    end
  end
end
