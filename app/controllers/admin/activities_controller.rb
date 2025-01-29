module Admin
  class ActivitiesController < BaseController
    before_action :set_activity, only: %i[ edit update destroy ]

    def index
      @activities = authorize policy_scope(Current.company.activities)
    end

    def new
      @activity = authorize Current.company.activities.new
      @activity.build_schedule

      render :form
    end

    def edit
      set_metadata title: @activity.name

      render :form
    end

    def create
      @activity = authorize Current.company.activities.new(activity_params)
      @activity.save!

      redirect_to admin_activities_path, notice: notice_message
    end

    def update
      @activity.update!(activity_params)

      flash.now.notice = notice_message

      respond_to do |format|
        format.turbo_stream { render_flash }
        format.html { redirect_to admin_activities_path, notice: notice_message }
      end
    end

    def destroy
      @activity.destroy!

      respond_to do |format|
        format.turbo_stream { render turbo_stream: turbo_stream.remove(dom_id(@activity)) }
        format.html { redirect_to admin_activities_path, notice: notice_message }
      end
    end

    private
      def set_activity
        @activity = authorize Current.company.activities.find(params[:id])
      end

      def activity_params
        params.require(:activity).permit(
          :name, :duration_minutes, :max_capacity, schedule_attributes: [
            :id, { virtual_schedule: [ :starts_on, :utc_offset, rules_attributes: [ :time, { day: [] } ] ] }
          ]
        )
      end
  end
end
