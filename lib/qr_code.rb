require "rqrcode"

class QrCode
  include Callable

  attr_reader :text, :offset

  def initialize(text, offset: 30)
    @text = text
    @offset = offset
  end

  def call
    RQRCode::QRCode.new(text).as_svg(offset:, viewbox: true).html_safe
  end
end
