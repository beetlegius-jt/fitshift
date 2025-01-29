class EventDecorator < ApplicationDecorator
  delegate_all

  def start_time
    h.l starts_at, format: :hour
  end

  def end_time
    h.l ends_at, format: :hour
  end

  def status_message
    scope = "activemodel.attributes.event.status"

    case status
    when Event::OPEN
      h.t(:open, scope:)
    when Event::FULL
      h.t(:full, scope:)
    when Event::AVAILABLE
      h.t(:available_html, scope:, date: h.timeago(reservation_start_time))
    else raise NotImplementedError
    end
  end

  def status_label
    h.tag.span status_label_anchor.upcase, class: [ "d-block", "badge", "mb-1", status_label_class ]
  end

  def availability
    "#{reservations_count}/#{activity_max_capacity}"
  end

  private

  def status_label_anchor
    scope = "activemodel.attributes.event.status_label"

    full? ? h.t(:full, scope:) : h.t(:available, scope:)
  end

  def status_label_class
    full? ? "text-bg-danger" : "text-bg-primary"
  end
end
