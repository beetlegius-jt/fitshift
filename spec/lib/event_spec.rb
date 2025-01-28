require 'rails_helper'

RSpec.describe Event, type: :model do
  let(:utc_offset) { -18000 }
  let(:company) { build(:company, utc_offset:) }

  let(:duration_minutes) { 60 }
  let(:max_capacity) { 10 }
  let(:activity) { build(:activity, company:, duration_minutes:, max_capacity:) }

  let(:starts_at) { Time.zone.parse("2025-01-01T08:00:00-05:00") }
  let(:hours_for_reservation) { 12 }
  let(:event) { build(:event, activity:, starts_at:, hours_for_reservation:) }

  before { Time.zone = company.utc_offset }

  context 'delegations' do
    subject { event }

    it { should delegate_method(:id).to(:activity).with_prefix }
    it { should delegate_method(:name).to(:activity).with_prefix }
    it { should delegate_method(:duration_minutes).to(:activity).with_prefix }
    it { should delegate_method(:max_capacity).to(:activity).with_prefix }
  end

  describe '.from_activities' do
    let(:from) { starts_at }
    let(:to) { 1.minute.after(from) }

    subject { described_class.from_activities([ activity ], from:, to:).as_json }

    it { is_expected.to eq([ event.as_json ]) }
  end

  describe '#hours_for_reservation' do
    subject { build(:event).hours_for_reservation }

    it { is_expected.to eq(Event::DEFAULT_HOURS_FOR_RESERVATION.hours) }
  end

  describe '#ends_at' do
    let(:starts_at) { Time.zone.parse("2025-01-01T09:00:00Z") }
    let(:ends_at) { Time.zone.parse("2025-01-01T10:00:00Z") }

    subject { event.ends_at }

    it { is_expected.to eq(ends_at) }
  end

  describe '#reservation_start_time' do
    let(:starts_at) { Time.zone.parse("2025-01-01T09:00:00Z") }
    let(:hours_for_reservation) { 4 }
    let(:reservation_start_time) { Time.zone.parse("2025-01-01T05:00:00Z") }

    subject { event.reservation_start_time }

    it { is_expected.to eq(reservation_start_time) }
  end

  describe '#reservations_count' do
    before { create(:reservation, activity:, starts_at:) }

    subject { event.reservations_count }

    it { is_expected.to eq(1) }
  end

  describe '#status' do
    subject { event.status }

    context 'when it is full' do
      before { allow(event).to receive(:full?).and_return(true) }

      it { is_expected.to eq(Event::FULL) }
    end

    context 'when it is open' do
      before { allow(event).to receive(:full?).and_return(false) }
      before { allow(event).to receive(:open?).and_return(true) }

      it { is_expected.to eq(Event::OPEN) }
    end

    context 'when it is available' do
      before { allow(event).to receive(:full?).and_return(false) }
      before { allow(event).to receive(:open?).and_return(false) }

      it { is_expected.to eq(Event::AVAILABLE) }
    end
  end

  describe '#full?' do
    let(:max_capacity) { 1 }

    subject { event.full? }

    context "when there are no reservations" do
      it { is_expected.to be_falsey }
    end

    context "when there are reservations" do
      before { create(:reservation, activity:, starts_at:) }

      it { is_expected.to be_truthy }
    end
  end

  describe '#open?' do
    subject { event.open? }

    context 'when the event is in the near future' do
      let(:starts_at) { 10.minutes.after }
      let(:hours_for_reservation) { 1 }

      it { is_expected.to be_truthy }
    end

    context 'when the event is in the distant future' do
      let(:starts_at) { 2.hours.after }
      let(:hours_for_reservation) { 1 }

      it { is_expected.to be_falsey }
    end
  end

  describe '#to_key' do
    let(:key) { [ activity.id, starts_at.to_i ] }

    subject { event.to_key }

    it { is_expected.to eq(key) }
  end

  describe '#to_partial_path' do
    subject { event.to_partial_path }

    it { is_expected.to eq("events/event") }
  end
end
