module App
  class EventsController < BaseController
    def index
      authorize :event, :index?

      @events = events_for_today.presence || events_for_tomorrow
    end

    private

    def activities
      @activities ||= Current.company.activities.includes(:schedule, :reservations, :company)
    end

    def events_for_today
      Event.from_activities(activities, from: 10.minutes.ago)
    end

    def events_for_tomorrow
      Event.from_activities(activities, from: Time.zone.tomorrow)
    end
  end
end
