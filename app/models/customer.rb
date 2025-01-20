# == Schema Information
#
# Table name: customers
#
#  id         :bigint           not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Customer < ApplicationRecord
  has_one_attached :picture

  validates :name, presence: true

  has_many :users, -> { where(role: "customer") }, as: :owner, dependent: :destroy
  has_many :attendances, dependent: :delete_all
  has_many :reservations, dependent: :delete_all
end
