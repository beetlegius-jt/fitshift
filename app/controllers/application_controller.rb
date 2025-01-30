class ApplicationController < ActionController::Base
  include Pundit::Authorization
  include HasMetadata
  include HasCurrentAttributes
  include ErrorHandler

  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  private

  def render_flash
    render turbo_stream: turbo_stream.update(:flash, partial: "layouts/flash")
  end

  def notice_message(key = action_name, **opts)
    t(key, scope: :notice, **opts)
  end

  def alert_message(key = action_name, **opts)
    t(key, scope: :alert, **opts)
  end
end
