module HasMetadata
  extend ActiveSupport::Concern

  Metadata = Data.define(:title, :description, :keywords)

  included do
    helper_method :metadata
  end

  private

  def metadata
    @metadata ||= set_metadata
  end

  def set_metadata(title: t(".title"), description: t(".description"), keywords: t(".keywords"))
    @metadata = Metadata.new(title:, description:, keywords:)
  end
end
