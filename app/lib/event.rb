class Event
  include Draper::Decoratable
  extend ActiveModel::Naming

  DEFAULT_HOURS_FOR_RESERVATION = 12
  STATUSES = [ FULL = "full", OPEN = "open", AVAILABLE = "available" ].freeze

  attr_reader :activity
  attr_reader :starts_at
  attr_reader :hours_for_reservation

  delegate :id, :name, :duration_minutes, :max_capacity, to: :activity, prefix: true

  def self.from_activities(activities, from: Time.zone.today, to: from.end_of_day)
    activities.flat_map do |activity|
      activity.schedule.occurrences_between(from, to).map { |starts_at| new(activity:, starts_at:) }
    end.sort_by(&:starts_at)
  end

  def initialize(activity:, starts_at:, hours_for_reservation: DEFAULT_HOURS_FOR_RESERVATION)
    @activity = activity
    @starts_at = starts_at
    @hours_for_reservation = hours_for_reservation.hours
  end

  def ends_at
    @ends_at ||= starts_at.advance(minutes: activity_duration_minutes)
  end

  def reservation_start_time
    @reservation_start_time ||= starts_at.ago(hours_for_reservation)
  end

  def reservations_count
    @reservation_count ||= activity.reservations.count { it.starts_at == starts_at }
  end

  def status
    return FULL if full?
    return OPEN if open?

    AVAILABLE
  end

  def full?
    @full ||= reservations_count >= activity_max_capacity
  end

  def open?
    @open ||= !full? && reservation_start_time.before?(Time.zone.now)
  end

  def to_key
    [ activity_id, starts_at.to_i ]
  end

  def to_partial_path
    "events/event"
  end
end
