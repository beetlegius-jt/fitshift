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
FactoryBot.define do
  factory :company do
    name { Faker::Company.name }
    logo { Rack::Test::UploadedFile.new('spec/fixtures/company.png', 'image/png') }
    utc_offset { Company::UTC_OFFSETS.sample }
    subdomain { Faker::Internet.unique.slug }
  end
end
