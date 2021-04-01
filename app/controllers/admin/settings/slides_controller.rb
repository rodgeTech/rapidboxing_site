# frozen_string_literal: true

module Admin
  module Settings
    class SlidesController < BaseController
      before_action :slide, only: %i[edit update destroy]

      def index
        @slides = Slide.order(created_at: :desc)
      end

      def new
        @slide = Slide.new
      end

      def create
        @slide = Slide.new(slide_params)
        if @slide.save
          save_image if params[:slide][:image]
          flash[:success] = 'Slide created successfully'
          redirect_to admin_settings_slides_path
        else
          render :new
        end
      end

      def update
        if @slide.update_attributes(slide_params)
          @slide.image.destroy if params[:slide][:image]
          save_image if params[:slide][:image]
          flash[:success] = 'Slide updated successfully'
          redirect_to admin_settings_slides_path
        else
          render :edit
        end
      end

      def destroy
        @slide.destroy
        flash[:success] = 'Slide removed successfully'
        redirect_to admin_settings_slides_path
      end

      private

      def slide_params
        params.require(:slide).permit(:main_title, :sub_title, :link_to, :link_text)
      end

      def save_image
        @slide.create_image!(image: params[:slide][:image])
      end

      def slide
        @slide ||= Slide.find(params[:id])
      end
    end
  end
end
