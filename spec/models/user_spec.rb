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
  end

  context 'associations' do
    it { should belong_to(:owner).optional }
  end

  context 'enumeratives' do
    it { should define_enum_for(:role).with_values(customer: 0, company: 10, admin: 20).validating }
  end
end
