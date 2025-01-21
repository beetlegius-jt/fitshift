module ApplicationHelper
  def nav_item(klass, path, **opts)
    anchor = klass.is_a?(Class) ? klass.model_name.human : klass

    tag.li link_to(anchor, path, class: "nav-link", **opts), class: "nav-item me-4"
  end
end
