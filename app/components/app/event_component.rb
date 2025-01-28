# frozen_string_literal: true

module App
  class EventComponent < ViewComponent::Base
    def initialize(event:)
      @event = event.decorate
      @activity = event.activity
    end
  end
end
