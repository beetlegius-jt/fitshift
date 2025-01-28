require 'rails_helper'

RSpec.describe ReservationDecorator do
  let(:activity) { build(:activity, duration_minutes: 60) }
  let(:starts_at) { Time.zone.parse("2025-01-27T09:00:00Z") }
  let(:reservation) { build(:reservation, activity:, starts_at:).decorate }

  describe "#start_time" do
    subject { reservation.start_time }

    it { is_expected.to eq("09:00") }
  end
end
