# == Schema Information
#
# Table name: customers
#
#  id         :bigint           not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require 'rails_helper'

RSpec.describe Customer do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
  end

  describe 'attachments' do
    it { is_expected.to have_one_attached(:picture) }
  end

  describe 'relationships' do
    it { is_expected.to have_many(:users).conditions(role: "customer").dependent(:destroy) }
    it { is_expected.to have_many(:attendances).dependent(:delete_all) }
    it { is_expected.to have_many(:reservations).dependent(:delete_all) }
  end
end
