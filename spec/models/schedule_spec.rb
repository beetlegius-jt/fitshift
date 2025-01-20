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
require 'rails_helper'

RSpec.describe Schedule, type: :model do
  context 'validations' do
    it { should validate_presence_of(:serialized_schedule) }
  end

  context 'relationships' do
    it { should belong_to(:schedulable) }
  end

  context 'delegations' do
    it { should delegate_method(:occurrences_between).to(:ice_cube) }
  end

  describe '#ice_cube' do
    subject { build(:schedule).ice_cube }

    it { is_expected.to be_a(IceCube::Schedule) }
  end
end
