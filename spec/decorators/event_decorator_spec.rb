require 'rails_helper'

RSpec.describe EventDecorator do
  include ActionView::Helpers::TagHelper
  include ApplicationHelper

  let(:activity) { build(:activity, duration_minutes: 60, max_capacity: 1) }
  let(:starts_at) { Time.zone.parse("2025-01-27T09:00:00Z") }
  let(:event) { build(:event, activity:, starts_at:).decorate }

  describe "#start_time" do
    subject { event.start_time }

    it { is_expected.to eq("09:00") }
  end

  describe "#end_time" do
    subject { event.end_time }

    it { is_expected.to eq("10:00") }
  end

  describe "#status_message" do
    subject { event.status_message }

    context "when the event is open" do
      let(:label) { I18n.t(:open, scope: "activemodel.attributes.event.status") }

      it { is_expected.to eq(label) }
    end

    context "when the event is full" do
      before { create(:reservation, activity:, starts_at:) }
      let(:label) { I18n.t(:full, scope: "activemodel.attributes.event.status") }

      it { is_expected.to eq(label) }
    end

    context "when the event is available" do
      let(:starts_at) { 1.day.after.round }
      let(:date) { timeago(event.reservation_start_time) }
      let(:label) { I18n.t(:available_html, scope: "activemodel.attributes.event.status", date:) }

      it { is_expected.to eq(label) }
    end
  end

  describe "#status_label" do
    subject { event.status_label }

    context "when the event is available" do
      let(:label) { I18n.t(:available, scope: "activemodel.attributes.event.status_label").upcase }

      it { is_expected.to include(label) }
    end

    context "when the event is full" do
      before { create(:reservation, activity:, starts_at:) }
      let(:label) { I18n.t(:full, scope: "activemodel.attributes.event.status_label").upcase }

      it { is_expected.to include(label) }
    end
  end
end
