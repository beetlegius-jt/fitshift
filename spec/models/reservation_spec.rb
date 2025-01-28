# == Schema Information
#
# Table name: reservations
#
#  id          :bigint           not null, primary key
#  starts_at   :datetime         not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  activity_id :bigint           not null
#  customer_id :bigint           not null
#
# Indexes
#
#  idx_on_starts_at_customer_id_activity_id_c502fbaf1c  (starts_at,customer_id,activity_id) UNIQUE
#  index_reservations_on_activity_id                    (activity_id)
#  index_reservations_on_customer_id                    (customer_id)
#
# Foreign Keys
#
#  fk_rails_...  (activity_id => activities.id)
#  fk_rails_...  (customer_id => customers.id)
#
require 'rails_helper'

RSpec.describe Reservation do
  include ActiveJob::TestHelper

  describe 'validations' do
    it { is_expected.to validate_presence_of(:starts_at) }

    describe 'uniqueness' do
      subject { build(:reservation) }

      it { is_expected.to validate_uniqueness_of(:starts_at).scoped_to(:customer_id, :activity_id) }
    end

    describe 'activity_is_available' do
      subject { build(:reservation, activity:, starts_at:) }

      let(:activity) { build(:activity) }
      let(:starts_at) { Time.zone.now.round }

      before { allow(activity).to receive(:available_at?).with(starts_at).and_return(available) }

      context 'when the activity is available' do
        let(:available) { true }

        it { is_expected.to be_valid }
      end

      context 'when the activity is not available' do
        let(:available) { false }

        it { is_expected.not_to be_valid }
      end
    end
  end

  describe 'relationships' do
    it { is_expected.to belong_to(:customer) }
    it { is_expected.to belong_to(:activity) }
  end

  describe 'scopes' do
    describe '.from_company' do
      subject { described_class.from_company(company) }

      let(:company) { create(:company) }
      let(:activity) { create(:activity, company:) }
      let!(:reservation) { create(:reservation, activity:) }

      before { create(:reservation) }

      it { is_expected.to contain_exactly(reservation) }
    end

    describe '.future' do
      subject { described_class.future }

      let(:starts_at) { Time.current.round }
      let!(:reservation1) { create(:reservation, starts_at:) }
      let!(:reservation2) { create(:reservation, starts_at: 1.hour.before(starts_at)) }

      before { create(:reservation, starts_at: 1.second.before(reservation2.starts_at)) }

      it { travel_to(starts_at) { is_expected.to contain_exactly(reservation1, reservation2) } }
    end
  end

  describe 'callbacks' do
    describe "broadcast_event" do
      let(:activity) { create(:activity) }
      let(:starts_at) { Time.current.round }
      let(:job) { BroadcastEventJob }
      let(:args) { [ activity, starts_at ] }
      let(:queue) { "default" }

      it "broadcasts event job on creation" do
        assert_enqueued_with(job:, args:, queue:) { create(:reservation, activity:, starts_at:) }
      end
    end
  end
end
