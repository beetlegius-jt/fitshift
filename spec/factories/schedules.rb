# == Schema Information
#
# Table name: schedules
#
#  id                  :bigint           not null, primary key
#  schedulable_type    :string           not null
#  serialized_schedule :json             not null
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  schedulable_id      :bigint           not null
#
# Indexes
#
#  index_schedules_on_schedulable  (schedulable_type,schedulable_id)
#
FactoryBot.define do
  factory :schedule do
    serialized_schedule { JSON.load_file("spec/fixtures/schedule.json") }

    schedulable factory: %i[activity]
  end
end
