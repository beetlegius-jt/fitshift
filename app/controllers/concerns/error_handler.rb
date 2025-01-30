module ErrorHandler
  extend ActiveSupport::Concern

  included do
    rescue_from ActiveRecord::RecordInvalid, with: :handle_record_invalid
    rescue_from Pundit::NotAuthorizedError, with: :handle_not_authorized

    def handle_record_invalid(exception)
      flash.now.alert = exception.message

      respond_to do |format|
        format.turbo_stream { render_flash }
        format.html { render :form }
      end
    end

    def handle_not_authorized(exception)
      sign_out

      redirect_to user_session_path
    end
  end
end
