# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  owner_type             :string
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  role                   :integer          default("customer"), not null
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  owner_id               :bigint
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_owner                 (owner_type,owner_id)
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
require 'rails_helper'

RSpec.describe User, type: :model do
  context 'validations' do
    it { should validate_presence_of(:role) }

    context 'when it is a customer' do
      subject { build(:user, :customer) }

      it { should validate_presence_of(:owner) }
    end

    context 'when it is a company' do
      subject { build(:user, :company) }

      it { should validate_presence_of(:owner) }
    end
  end

  context 'associations' do
    context 'when it is a admin' do
      subject { build(:user, :admin) }

      it { should belong_to(:owner).optional }
    end
  end

  context 'enumeratives' do
    it { should define_enum_for(:role).with_values(customer: 0, company: 10, admin: 20).validating }
  end

  describe '#customer' do
    subject { user.customer }

    context 'when it is an admin' do
      let(:user) { build(:user, :admin) }

      it { is_expected.to be_nil }
    end

    context 'when it is a customer' do
      let(:user) { build(:user, :customer) }

      it { is_expected.to eq(user.owner) }
    end

    context 'when it is a company' do
      let(:user) { build(:user, :company) }

      it { is_expected.to be_nil }
    end
  end

  describe '#company' do
    subject { user.company }

    context 'when it is an admin' do
      let(:user) { build(:user, :admin) }

      it { is_expected.to be_nil }
    end

    context 'when it is a customer' do
      let(:user) { build(:user, :customer) }

      it { is_expected.to be_nil }
    end

    context 'when it is a company' do
      let(:user) { build(:user, :company) }

      it { is_expected.to eq(user.owner) }
    end
  end
end
