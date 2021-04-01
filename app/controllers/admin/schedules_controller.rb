# frozen_string_literal: true

module Admin
  class SchedulesController < BaseController
    before_action :schedule, only: %i[edit update destroy]

    def index
      @schedules = Schedule.order(departure: :desc).page(params[:page]).per(5)
    end

    def new
      @schedule = Schedule.new
    end

    def create
      @schedule = Schedule.new(schedule_params)
      if @schedule.save
        flash[:success] = 'Schedule created successfully'
        redirect_to admin_schedules_path
      else
        render :new
      end
    end

    def edit; end

    def update
      if @schedule.update_attributes(schedule_params)
        flash[:success] = 'Schedule updated successfully'
        redirect_to admin_schedules_path
      else
        render :edit
      end
    end

    def destroy
      @schedule.destroy
      flash[:success] = 'Schedule removed successfully'
      redirect_to admin_schedules_path
    end

    private

    def schedule_params
      params.require(:schedule).permit(:departure, :arrival)
    end

    def schedule
      @schedule ||= Schedule.find_by!(id: params[:id])
    end
  end
end
