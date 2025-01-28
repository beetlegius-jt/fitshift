# frozen_string_literal: true

require "rails_helper"

RSpec.describe App::EventComponent, type: :component do
  subject { render_inline(described_class.new(event:)).to_html }

  let(:activity) { create(:activity, duration_minutes: 60, max_capacity: 1) }
  let(:starts_at) { Time.current.change(hour: 10, minute: 0, second: 0) }
  let(:event) { build(:event, activity:, starts_at:) }

  let(:new_reservation_url) { new_app_activity_reservation_path(activity, reservation: { starts_at: starts_at.iso8601 }) }
  let(:time) { "10:00 - 11:00" }
  let(:attendance) { "0/1" }
  let(:status_message) { I18n.t(:open, scope: "activemodel.attributes.event.status") }
  let(:status_label) { I18n.t(:available, scope: "activemodel.attributes.event.status_label").upcase }


  it { is_expected.to include(activity.name) }
  it { is_expected.to include(new_reservation_url) }
  it { is_expected.to include(time) }
  it { is_expected.to include(attendance) }
  it { is_expected.to include(status_message) }
  it { is_expected.to include(status_label) }

  context "when there is a reservation" do
    before { create(:reservation, activity:, starts_at:) }

    let(:attendance) { "1/1" }
    let(:status_message) { I18n.t(:full, scope: "activemodel.attributes.event.status") }
    let(:status_label) { I18n.t(:full, scope: "activemodel.attributes.event.status_label").upcase }

    it { is_expected.to include(attendance) }
    it { is_expected.to include(status_message) }
    it { is_expected.to include(status_label) }
  end

  context "when the event is in the future" do
    let(:starts_at) { 1.day.after }
    let(:status_message) do
      I18n.t(:available_html, scope: "activemodel.attributes.event.status", date: timeago(event.reservation_start_time))
    end
    let(:status_label) { I18n.t(:available, scope: "activemodel.attributes.event.status_label").upcase }

    it { is_expected.to include(status_message) }
    it { is_expected.to include(status_label) }
  end
end
