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

RSpec.describe Company do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:utc_offset) }
    it { is_expected.to validate_presence_of(:subdomain) }
    it { is_expected.to validate_numericality_of(:utc_offset).only_integer }
    it { is_expected.to validate_inclusion_of(:utc_offset).in_array(Company::UTC_OFFSETS) }

    describe 'uniqueness' do
      subject { build(:company) }

      it { is_expected.to validate_uniqueness_of(:subdomain) }
    end
  end

  describe 'attachments' do
    it { is_expected.to have_one_attached(:logo) }

    describe 'logo#thumb' do
      subject { create(:company).logo.variant(:thumb) }

      it { is_expected.to be_a(ActiveStorage::VariantWithRecord) }
    end
  end

  describe 'relationships' do
    it { is_expected.to have_many(:users).conditions(role: "company").dependent(:destroy) }
    it { is_expected.to have_many(:activities).dependent(:destroy) }
    it { is_expected.to have_many(:attendances).dependent(:delete_all) }
  end
end
