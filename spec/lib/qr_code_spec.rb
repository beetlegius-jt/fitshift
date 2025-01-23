require 'rails_helper'

RSpec.describe QrCode, type: :model do
  describe ".call" do
    let(:text) { "whatever" }
    let(:offset) { 100 }
    let(:qr_code) { instance_double("RQRCode::QRCode") }
    let(:result) { "some valid html" }

    subject { described_class.call(text, offset:) }

    before do
      allow(RQRCode::QRCode).to receive(:new).with(text).and_return(qr_code)
      allow(qr_code).to receive(:as_svg).with(offset:, viewbox: true).and_return(result)
    end

    it { is_expected.to eq(result) }
  end
end
