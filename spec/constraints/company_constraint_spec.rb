require 'rails_helper'

RSpec.describe CompanyConstraint, type: :model do
  describe "#matches?" do
    let(:subdomain) { "whatever" }
    let(:request) { double("request") }

    before { allow(request).to receive(:subdomain).and_return(subdomain) }

    subject { described_class.new.matches?(request) }

    context "when there is a company with the given subdomain" do
      before { create(:company, subdomain:) }

      it { is_expected.to be_truthy }
    end

    context "when there is no company with the given subdomain" do
      it { is_expected.to be_falsy }
    end
  end
end
