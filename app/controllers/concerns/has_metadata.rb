module HasMetadata
  extend ActiveSupport::Concern

  Metadata = Data.define(:title)

  included do
    helper_method :metadata
  end

  private

  def metadata
    @metadata ||= set_metadata
  end

  def set_metadata(title: t(".title"))
    @metadata = Metadata.new(title:)
  end
end
