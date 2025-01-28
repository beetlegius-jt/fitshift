# frozen_string_literal: true

class ApplicationBroadcaster
  include Turbo::Streams::Broadcasts, Turbo::Streams::StreamName
  include ActionView::RecordIdentifier
  include Callable

  delegate :helpers, :render, to: :application_controller

  private

  def application_controller
    ApplicationController
  end
end
