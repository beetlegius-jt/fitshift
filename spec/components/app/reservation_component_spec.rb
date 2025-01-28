# frozen_string_literal: true

require "rails_helper"

RSpec.describe App::ReservationComponent, type: :component do
  include ActionView::Helpers::TagHelper
  include Rails.application.routes.url_helpers
  include ApplicationHelper

  let(:activity) { create(:activity) }
  let(:starts_at) { Time.current.change(hour: 10, minute: 0, second: 0) }
  let(:reservation) { create(:reservation, activity:, starts_at:) }

  let(:reservation_url) { app_reservation_path(reservation) }
  let(:time) { "10:00" }
  let(:timeago_message) { timeago(starts_at)  }

  subject { render_inline(described_class.new(reservation:)).to_html }

  it { is_expected.to include(activity.name) }
  it { is_expected.to include(reservation_url) }
  it { is_expected.to include(time) }
  it { is_expected.to include(timeago_message) }
end
