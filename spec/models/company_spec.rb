# == Schema Information
#
# Table name: companies
#
#  id         :bigint           not null, primary key
#  name       :string           not null
#  subdomain  :string           not null
#  utc_offset :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_companies_on_subdomain  (subdomain) UNIQUE
#
require 'rails_helper'

RSpec.describe Company, type: :model do
  context 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:utc_offset) }
    it { should validate_presence_of(:subdomain) }
    it { should validate_numericality_of(:utc_offset).only_integer }
    it { should validate_inclusion_of(:utc_offset).in_array(Company::UTC_OFFSETS) }

    context 'uniqueness' do
      subject { build(:company) }

      it { should validate_uniqueness_of(:subdomain) }
    end
  end

  context 'attachments' do
    it { should have_one_attached(:logo) }

    describe 'logo' do
      describe "thumb" do
        subject { create(:company).logo.variant(:thumb) }

        it { is_expected.to be_a(ActiveStorage::VariantWithRecord) }
      end
    end
  end

  context 'relationships' do
    it { should have_many(:users).conditions(role: "company").dependent(:destroy) }
    it { should have_many(:activities).dependent(:destroy) }
    it { should have_many(:attendances).dependent(:delete_all) }
  end
end
