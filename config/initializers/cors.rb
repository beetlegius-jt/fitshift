Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins "*"

    resource "/users/sign_in", headers: :any, methods: [ :get ]
  end
end
