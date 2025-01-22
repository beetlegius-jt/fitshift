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

  describe "#virtual_schedule" do
    let(:virtual_schedule) { instance_double("VirtualSchedule") }
    let(:schedule) { build(:schedule) }

    before { allow(VirtualScheduleManager).to receive(:deserialize).with(schedule.ice_cube).and_return(virtual_schedule) }

    subject { schedule.virtual_schedule }

    it { is_expected.to eq(virtual_schedule) }
  end

  describe "#virtual_schedule=" do
    let(:serialized_schedule) { { some: "schedule" } }
    let(:schedule) { build(:schedule) }
    let(:params) { { some: "params" } }

    before { allow(VirtualScheduleManager).to receive(:serialize).with(params).and_return(serialized_schedule) }

    it "set serialized_schedule" do
      schedule.virtual_schedule = params

      expect(schedule.serialized_schedule).to eq(serialized_schedule.as_json)
    end
  end
end
