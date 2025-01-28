require 'rails_helper'

RSpec.describe BroadcastEventJob, type: :job do
  let(:activity) { build(:activity) }
  let(:starts_at) { Time.current.round }
  let(:queue_name) { "default" }
  let(:job) { described_class.new(activity, starts_at) }

  it { expect(job.queue_name).to eq(queue_name) }

  describe "#perform_now" do
    let(:result) { "whatever" }

    subject { job.perform_now }

    before { allow(EventBroadcaster).to receive(:call).with(activity, starts_at).and_return(result) }

    it { is_expected.to eq(result) }
  end
end
