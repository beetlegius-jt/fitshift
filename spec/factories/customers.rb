# == Schema Information
#
# Table name: customers
#
#  id         :bigint           not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
FactoryBot.define do
  factory :customer do
    name { Faker::Name.name }
    picture { Rack::Test::UploadedFile.new('spec/fixtures/customer.png', 'image/png') }
  end
end
