module App
  class AgendaComponent < ViewComponent::Base
    def initialize(events:)
      @grouped_events = events.group_by { |event| event.starts_at.to_date }
      @weekdays = Time.zone.today.all_week
    end
  end
end
