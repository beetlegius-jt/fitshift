require 'rails_helper'

RSpec.describe EventBroadcaster, type: :broadcaster do
  let(:activity) { create(:activity) }
  let(:starts_at) { Time.current.round }
  let(:event) { build(:event, activity:, starts_at:) }
  let(:stream) { ActionView::RecordIdentifier.dom_id(activity.company, :events) }
  let(:target) { ActionView::RecordIdentifier.dom_id(event) }

  describe "#call" do
    subject(:broadcaster) { described_class.new(activity, starts_at) }

    it { expect { broadcaster.call }.to have_broadcasted_turbo_stream_to(stream, action: :replace, target:) }
  end
end
