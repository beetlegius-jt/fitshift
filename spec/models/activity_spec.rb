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
require 'rails_helper'

RSpec.describe Activity do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:duration_minutes) }
    it { is_expected.to validate_presence_of(:max_capacity) }
    it { is_expected.to validate_numericality_of(:duration_minutes).is_greater_than(0).only_integer }
    it { is_expected.to validate_numericality_of(:max_capacity).is_greater_than(0).only_integer }
  end

  describe 'relationships' do
    it { is_expected.to belong_to(:company) }
    it { is_expected.to have_one(:schedule).dependent(:destroy) }
    it { is_expected.to have_many(:reservations).dependent(:delete_all) }
    it { is_expected.to accept_nested_attributes_for(:schedule) }
  end

  describe '#available_at?' do
    subject { activity.available_at?(starts_at) }

    let(:starts_at) { Time.current }
    let(:activity) { build(:activity, max_capacity: 1) }


    context 'when there is capacity' do
      it { is_expected.to be_truthy }
    end

    context 'when there is no capacity' do
      before { create(:reservation, activity:, starts_at:) }

      it { is_expected.to be_falsy }
    end
  end
end
