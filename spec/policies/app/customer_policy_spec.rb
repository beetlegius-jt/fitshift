require 'rails_helper'

RSpec.describe App::CustomerPolicy, type: :policy do
  let(:customer) { build(:customer) }

  subject { described_class }

  before { Current.customer = customer }

  permissions :show? do
    context "when the user is not logged in" do
      let(:user) { nil }

      it { is_expected.not_to permit(user, customer) }
    end

    context "when the user is an admin" do
      let(:user) { build(:user, :admin) }

      it { is_expected.not_to permit(user, customer) }
    end

    context "when the user is a company" do
      let(:user) { build(:user, :company) }

      it { is_expected.not_to permit(user, customer) }
    end

    context "when the user is a customer" do
      let(:user) { build(:user, :customer, owner: customer) }

      it { is_expected.to permit(user, customer) }
    end
  end
end
