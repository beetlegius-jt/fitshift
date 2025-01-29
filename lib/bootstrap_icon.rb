class BootstrapIcon
  include Callable
  include ActionView::Helpers::TagHelper

  attr_reader :name, :right, :text, :klass, :html_options

  def initialize(name, right: false, text: nil, **html_options)
    @name = name
    @right = right
    @text = ERB::Util.html_escape(text).presence
    @klass = html_options.delete(:class)
    @html_options = html_options
  end

  def call
    elements = [ icon, text ]
    elements.reverse! if right

    elements.join.html_safe
  end

  private

  def icon
    @icon ||= tag.i(class: css_classes, **html_options)
  end

  def css_classes
    [
      klass,
      "bi",
      "bi-#{name}",
      { "ms-1": text && right },
      { "me-1": text && !right }
    ]
  end
end
