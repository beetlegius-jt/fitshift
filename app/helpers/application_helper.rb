module ApplicationHelper
  def nav_item(klass, path, **opts)
    anchor = klass.is_a?(Class) ? klass.model_name.human.pluralize : klass

    tag.li link_to(anchor, path, class: "nav-link", **opts), class: "nav-item me-4"
  end

  def timeago(date, format: :long)
    return if date.blank?

    title = content = I18n.l(date, format:)

    tag.time(
      content, title:, data: { controller: "timeago", timeago_datetime_value: date.iso8601 }
    )
  end
end
