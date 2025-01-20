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
class Schedule < ApplicationRecord
  belongs_to :schedulable, polymorphic: true

  validates :serialized_schedule, presence: true

  delegate :occurrences_between, to: :ice_cube

  def ice_cube
    @ice_cube ||= begin
      IceCube::Schedule.from_yaml(serialized_schedule.to_yaml)
    rescue StandardError
      IceCube::Schedule.new
    end
  end
end
