RSpec.shared_examples "a customer resource" do
  let(:owner) { Current.customer }

  context "when the user is not logged in" do
    let(:user) { nil }

    it { is_expected.not_to permit(user, resource) }
  end

  context "when the user is an admin" do
    let(:user) { build(:user, :admin) }

    it { is_expected.not_to permit(user, resource) }
  end

  context "when the user is a company" do
    let(:user) { build(:user, :company) }

    it { is_expected.not_to permit(user, resource) }
  end

  context "when the user is a customer" do
    let(:user) { build(:user, :customer, owner:) }

    it { is_expected.to permit(user, resource) }
  end
end
