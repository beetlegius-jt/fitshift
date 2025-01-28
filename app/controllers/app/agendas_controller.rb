module App
  class AgendasController < BaseController
    def show
      authorize :agenda, :show?

      activities = policy_scope(Current.company.activities).includes(:schedule)
      week = Time.zone.today.all_week

      @events = EventDecorator.decorate_collection(
        Event.from_activities(activities, from: week.begin, to: week.end)
      )
    end
  end
end
