FactoryBot.define do
  factory :event do
    starts_at { Time.current.round }
    association :activity

    initialize_with { new(**attributes) }
    skip_create
  end
end
