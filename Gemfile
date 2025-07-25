source "https://rubygems.org"

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem "rails", "~> 8.0.2"
# The modern asset pipeline for Rails [https://github.com/rails/propshaft]
gem "propshaft"
# Use postgresql as the database for Active Record
gem "pg", "~> 1.1"
# Use the Puma web server [https://github.com/puma/puma]
gem "puma", ">= 5.0"
# Use JavaScript with ESM import maps [https://github.com/rails/importmap-rails]
gem "importmap-rails"
# Hotwire's SPA-like page accelerator [https://turbo.hotwired.dev]
gem "turbo-rails"
# Hotwire's modest JavaScript framework [https://stimulus.hotwired.dev]
gem "stimulus-rails"
# Bundle and process CSS [https://github.com/rails/cssbundling-rails]
gem "cssbundling-rails"

# Use Active Model has_secure_password [https://guides.rubyonrails.org/active_model_basics.html#securepassword]
# gem "bcrypt", "~> 3.1.7"

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: %i[ windows jruby ]

# Use the database-backed adapters for Rails.cache, Active Job, and Action Cable
gem "solid_cache"
gem "solid_queue"
gem "solid_cable"

# Reduces boot times through caching; required in config/boot.rb
gem "bootsnap", require: false

# Deploy this application anywhere as a Docker container [https://kamal-deploy.org]
gem "kamal", require: false

# Add HTTP asset caching/compression and X-Sendfile acceleration to Puma [https://github.com/basecamp/thruster/]
gem "thruster", require: false

# Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]
gem "image_processing", "~> 1.14"

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem "debug", platforms: %i[ mri windows ], require: "debug/prelude"

  # Static analysis for security vulnerabilities [https://brakemanscanner.org/]
  gem "brakeman", require: false

  gem "rubocop", "~> 1.78", require: false
  gem "rubocop-rails", "~> 2.32", require: false
  # Omakase Ruby styling [https://github.com/rails/rubocop-rails-omakase/]
  gem "rubocop-rails-omakase", require: false
  gem "rubocop-rspec", "~> 3.6", require: false
  gem "rubocop-performance", "~> 1.25", require: false
  gem "rubocop-rspec_rails", "~> 2.31", require: false
  gem "rubocop-capybara", "~> 2.22", require: false
  gem "rubocop-factory_bot", "~> 2.27", require: false
  gem "rubocop-faker", "~> 1.3", require: false

  gem "factory_bot_rails", "~> 6.5"
  gem "faker", "~> 3.5"
  gem "rspec-rails", "~> 8.0"
end

group :development do
  # Use console on exceptions pages [https://github.com/rails/web-console]
  gem "web-console"

  gem "annotaterb", "~> 4.16", require: false
  gem "rails-erd", "~> 1.7"
end

group :test do
  # Use system testing [https://guides.rubyonrails.org/testing.html#system-testing]
  gem "capybara"
  gem "selenium-webdriver"

  gem "shoulda-matchers", "~> 6.5"
  gem "simplecov", "~> 0.22.0", require: false
end

gem "combined_time_select", "~> 2.0"
gem "datadog", "~> 2.17", require: "datadog/auto_instrument"
gem "devise", "~> 4.9"
gem "draper", "~> 4.0"
gem "ice_cube", "~> 0.17.0"
gem "pundit", "~> 2.5"
gem "rack-cors", "~> 3.0"
gem "rqrcode", "~> 3.1", require: false
gem "view_component", "~> 3.23"
