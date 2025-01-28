require 'rails_helper'

RSpec.describe ApplicationBroadcaster, type: :broadcaster do
  describe 'modules' do
    subject { described_class.included_modules }

    it { is_expected.to include(Callable) }
    it { is_expected.to include(ActionView::RecordIdentifier) }
    it { is_expected.to include(Turbo::Streams::Broadcasts) }
    it { is_expected.to include(Turbo::Streams::StreamName) }
  end

  describe 'delegations' do
    it { is_expected.to delegate_method(:helpers).to(:application_controller) }
    it { is_expected.to delegate_method(:render).to(:application_controller) }
  end
end
