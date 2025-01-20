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

RSpec.describe Reservation, type: :model do
  context 'validations' do
    it { should validate_presence_of(:starts_at) }

    context 'uniqueness' do
      subject { build(:reservation) }

      it { should validate_uniqueness_of(:starts_at).scoped_to(:customer_id, :activity_id) }
    end

    describe 'activity_is_available' do
      subject { build(:reservation) }
      before { allow(subject.activity).to receive(:available_at?).with(subject.starts_at).and_return(available) }

      context 'when the activity is available' do
        let(:available) { true }

        it { is_expected.to be_valid }
      end

      context 'when the activity is not available' do
        let(:available) { false }

        it { is_expected.to be_invalid }
      end
    end
  end

  context 'relationships' do
    it { should belong_to(:customer) }
    it { should belong_to(:activity) }
  end
end
