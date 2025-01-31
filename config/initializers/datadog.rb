Datadog.configure do |c|
  c.tracing.enabled = !Rails.env.local?
end
