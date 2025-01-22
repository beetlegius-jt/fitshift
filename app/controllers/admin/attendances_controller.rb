module Admin
  class AttendancesController < BaseController
    before_action :set_attendance, only: [ :destroy ]

    def index
      @attendances = authorize policy_scope(Current.company.attendances).order(created_at: :desc)
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
  end
end
