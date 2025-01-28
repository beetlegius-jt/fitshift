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
FactoryBot.define do
  factory :user do
    email { Faker::Internet.unique.email }
    password { Faker::Internet.password }

    trait :admin do
      role { :admin }
      owner { nil }
    end

    trait :customer do
      role { :customer }
      owner factory: %i[customer]
    end

    trait :company do
      role { :company }
      owner factory: %i[company]
    end
  end
end
