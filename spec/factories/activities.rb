# == Schema Information
#
# Table name: activities
#
#  id               :bigint           not null, primary key
#  duration_minutes :integer          default(60), not null
#  max_capacity     :integer          default(15), not null
#  name             :string           not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  company_id       :bigint           not null
#
# Indexes
#
#  index_activities_on_company_id  (company_id)
#
# Foreign Keys
#
#  fk_rails_...  (company_id => companies.id)
#
FactoryBot.define do
  factory :activity do
    name { Faker::Lorem.word }
    duration_minutes { [ 30, 60, 90 ].sample }
    max_capacity { [ 5, 10, 15, 18, 20 ].sample }

    company
    schedule { association(:schedule, schedulable: instance) }
  end
end
