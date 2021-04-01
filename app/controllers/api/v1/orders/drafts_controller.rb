# frozen_string_literal: true

module Api
  module V1
    module Orders
      class DraftsController < BaseController
        before_action :order, only: %i[show publish destroy]

        def show
          render json: OrderSerializer.new(@order).serialized_json
        end

        def create
          order = Order.new(order_params)
          if order.save
            render json: { message: 'Draft order successfully created', id: order.id },
                   status: :created

          else
            render json: { errors: order.errors.full_messages },
                   status: :unprocessable_entity
          end
        end

        def publish
          if @order.order_items.none?
            render json: { errors: 'You need to add at least one draft item before publishing' },
                   status: :unprocessable_entity
          else
            @order.update_attributes(draft: false)
            head :ok
          end
        end

        def destroy
          @order.destroy
          head :ok
        end

        private

        def order_params
          params.permit(:id, :email, :contact_number, :name,
                        :address, :user_id, draft: true)
        end

        def order
          @order ||= Order.find(params[:id])
        end
      end
    end
  end
end
