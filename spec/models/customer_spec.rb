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

RSpec.describe Customer, type: :model do
  context 'validations' do
    it { should validate_presence_of(:name) }
  end

  context 'attachments' do
    it { should have_one_attached(:picture) }
  end

  context 'relationships' do
    it { should have_many(:users).conditions(role: "customer").dependent(:destroy) }
    it { should have_many(:attendances).dependent(:delete_all) }
    it { should have_many(:reservations).dependent(:delete_all) }
  end
end
