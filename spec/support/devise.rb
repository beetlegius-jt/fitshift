RSpec.configure do |config|
  # config.include Devise::Test::IntegrationHelpers, type: :request
  config.include Devise::Test::IntegrationHelpers, type: :system

  # TODO: Remove when Devise fixes https://github.com/heartcombo/devise/issues/5705
  config.before(:each, type: :system) do
    Rails.application.reload_routes_unless_loaded
  end
end
