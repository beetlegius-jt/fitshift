class EventBroadcaster < ApplicationBroadcaster
  def initialize(activity, starts_at)
    @event = Event.new(activity:, starts_at:)
  end

  def call
    broadcast_event
  end

  private

  attr_reader :event

  def broadcast_event
    stream = dom_id(event.activity.company, :events)
    target = dom_id(event)
    html = render(App::EventComponent.new(event:), layout: false)

    broadcast_replace_to(stream, target:, html:)
  end
end
