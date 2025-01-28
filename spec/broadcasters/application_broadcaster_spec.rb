require 'rails_helper'

RSpec.describe ApplicationBroadcaster, type: :broadcaster do
  context 'modules' do
    subject { described_class.included_modules }

    it { should include(Callable) }
    it { should include(ActionView::RecordIdentifier) }
    it { should include(Turbo::Streams::Broadcasts) }
    it { should include(Turbo::Streams::StreamName) }
  end

  context 'delegations' do
    it { should delegate_method(:helpers).to(:application_controller) }
    it { should delegate_method(:render).to(:application_controller) }
  end
end
