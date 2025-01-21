require 'rails_helper'

RSpec.describe CompaniesHelper, type: :helper do
  describe 'options_for_utc_offset' do
    let(:utc_offset) { "whatever" }
    let(:seconds_to_utc_offset) { "text" }

    before do
      stub_const("Company::UTC_OFFSETS", [ utc_offset ])

      allow(ActiveSupport::TimeZone).to receive(:seconds_to_utc_offset).with(utc_offset).and_return(seconds_to_utc_offset)
    end

    subject { helper.options_for_utc_offset }

    it { is_expected.to eq([ [ seconds_to_utc_offset, utc_offset ] ]) }
  end
end
