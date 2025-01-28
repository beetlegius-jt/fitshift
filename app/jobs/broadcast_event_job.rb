class BroadcastEventJob < ApplicationJob
  queue_as :default

  def perform(activity, starts_at)
    EventBroadcaster.call(activity, starts_at)
  end
end
