require 'rails_helper'

RSpec.describe CompanyPolicy, type: :policy do
  let(:company) { build(:company) }

  subject { described_class }

  before { Current.company = company }

  permissions :show?, :update? do
    context "when the user is not logged in" do
      let(:user) { nil }

      it { is_expected.not_to permit(user, company) }
    end

    context "when the user is an admin" do
      let(:user) { build(:user, :admin) }

      it { is_expected.not_to permit(user, company) }
    end

    context "when the user is a customer" do
      let(:user) { build(:user, :customer) }

      it { is_expected.not_to permit(user, company) }
    end

    context "when the user is a company" do
      let(:user) { build(:user, :company, owner: company) }

      it { is_expected.to permit(user, company) }
    end
  end
end
