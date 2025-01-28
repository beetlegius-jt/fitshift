require 'rails_helper'

RSpec.describe CompanyConstraint, type: :model do
  describe "#matches?" do
    subject { described_class.new.matches?(request) }

    let(:subdomain) { "whatever" }
    let(:request) { instance_double(ActionDispatch::Request) }

    before { allow(request).to receive(:subdomain).and_return(subdomain) }


    context "when there is a company with the given subdomain" do
      before { create(:company, subdomain:) }

      it { is_expected.to be_truthy }
    end

    context "when there is no company with the given subdomain" do
      it { is_expected.to be_falsy }
    end
  end
end
