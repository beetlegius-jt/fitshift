require 'view_component/test_helpers'

RSpec.configure do |config|
  config.include ViewComponent::TestHelpers, type: :component
  config.include ActionView::Helpers::TagHelper, type: :component
  config.include Rails.application.routes.url_helpers, type: :component
  config.include ApplicationHelper, type: :component
end
