# frozen_string_literal: true

require "rails_helper"

RSpec.describe App::AgendaComponent, type: :component do
  subject { render_inline(described_class.new(events: [ event1, event2 ])).to_html }

  let(:activity) { build(:activity) }
  let(:event1) { build(:event, activity:, starts_at: Time.current.beginning_of_week).decorate }
  let(:event2) { build(:event, activity:, starts_at: Time.current.end_of_week).decorate }

  Time.zone.today.all_week.each do |date|
    it { is_expected.to include(date.strftime("%A")) }
  end

  it { is_expected.to include(activity.name) }
  it { is_expected.to include(event1.start_time) }
  it { is_expected.to include(event1.end_time) }
  it { is_expected.to include(event2.start_time) }
  it { is_expected.to include(event2.end_time) }
end
