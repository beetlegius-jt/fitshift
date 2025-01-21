module ErrorHandler
  extend ActiveSupport::Concern

  included do
    rescue_from ActiveRecord::RecordInvalid, with: :handle_record_invalid

    def handle_record_invalid(exception)
      flash.now.alert = exception.message

      respond_to do |format|
        format.turbo_stream { render_flash }
        format.html { render :edit }
      end
    end
  end
end
