require 'rails_helper'

RSpec.describe Admin::AttendancePolicy, type: :policy do
  let(:company) { build(:company) }

  subject { described_class }

  before { Current.company = company }

  permissions :index?, :create? do
    context "when the user is not logged in" do
      let(:user) { nil }

      it { is_expected.not_to permit(user, Attendance) }
    end

    context "when the user is not the owner" do
      let(:user) { build(:user, :company) }

      it { is_expected.not_to permit(user, Attendance) }
    end

    context "when the user is the owner" do
      let(:user) { build(:user, :company, owner: company) }

      it { is_expected.to permit(user, Attendance) }
    end
  end

  permissions :show?, :destroy? do
    let(:attendance) { build(:attendance, company:) }

    context "when the user is not logged in" do
      let(:user) { nil }

      it { is_expected.not_to permit(user, attendance) }
    end

    context "when the attendance is from a different company" do
      let(:user) { build(:user, :company, owner: company) }
      let(:attendance) { build(:attendance) }

      it { is_expected.not_to permit(user, attendance) }
    end

    context "when the attendance is from the user company" do
      let(:user) { build(:user, :company, owner: company) }

      it { is_expected.to permit(user, attendance) }
    end
  end
end
