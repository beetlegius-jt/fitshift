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
class Company < ApplicationRecord
  UTC_OFFSETS = ActiveSupport::TimeZone.all.map(&:utc_offset).uniq.freeze

  validates :name, presence: true
  validates :utc_offset, presence: true
  validates :utc_offset, numericality: { only_integer: true }
  validates :utc_offset, inclusion: UTC_OFFSETS
  validates :subdomain, presence: true
  validates :subdomain, uniqueness: true

  has_one_attached :logo

  has_many :users, -> { where(role: "company") }, as: :owner, dependent: :destroy
  has_many :activities, dependent: :destroy
end
