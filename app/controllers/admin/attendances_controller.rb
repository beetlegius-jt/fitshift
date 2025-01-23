module Admin
  class AttendancesController < BaseController
    before_action :set_attendance, only: [ :show, :destroy ]

    def index
      @attendances = authorize policy_scope(Current.company.attendances).order(created_at: :desc)
    end

    def show
    end

    def new
      @attendance = authorize Current.company.attendances.new

      render :form
    end

    def create
      @attendance = authorize Current.company.attendances.new(attendance_params)
      @attendance.save!

      redirect_to [ :admin, @attendance ]
    end

    def destroy
      @attendance.destroy!

      respond_to do |format|
        format.turbo_stream { render turbo_stream: turbo_stream.remove(dom_id(@attendance)) }
        format.html { redirect_to admin_attendances_path, notice: notice_message }
      end
    end

    private

    def set_attendance
      @attendance = authorize policy_scope(Current.company.attendances).find(params[:id])
    end

    def attendance_params
      params.require(:attendance).permit(:customer_id).with_defaults(attended_at: Time.zone.now)
    end
  end
end
