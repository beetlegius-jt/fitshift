require 'rails_helper'

RSpec.describe Admin::ActivityPolicy, type: :policy do
  subject { described_class }

  let(:company) { build(:company) }


  before { Current.company = company }

  permissions :index?, :create? do
    context "when the user is not logged in" do
      let(:user) { nil }

      it { is_expected.not_to permit(user, Activity) }
    end

    context "when the user is not the owner" do
      let(:user) { build(:user, :company) }

      it { is_expected.not_to permit(user, Activity) }
    end

    context "when the user is the owner" do
      let(:user) { build(:user, :company, owner: company) }

      it { is_expected.to permit(user, Activity) }
    end
  end

  permissions :update?, :destroy? do
    let(:activity) { build(:activity, company:) }

    context "when the user is not logged in" do
      let(:user) { nil }

      it { is_expected.not_to permit(user, activity) }
    end

    context "when the activity is from a different company" do
      let(:user) { build(:user, :company, owner: company) }
      let(:activity) { build(:activity) }

      it { is_expected.not_to permit(user, activity) }
    end

    context "when the activity is from the user company" do
      let(:user) { build(:user, :company, owner: company) }

      it { is_expected.to permit(user, activity) }
    end
  end
end
