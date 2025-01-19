# == Schema Information
#
# Table name: activities
#
#  id               :bigint           not null, primary key
#  duration_minutes :integer          default(60), not null
#  max_capacity     :integer          default(15), not null
#  name             :string           not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  company_id       :bigint           not null
#
# Indexes
#
#  index_activities_on_company_id  (company_id)
#
# Foreign Keys
#
#  fk_rails_...  (company_id => companies.id)
#
class Activity < ApplicationRecord
  validates :name, presence: true
  validates :duration_minutes, presence: true
  validates :duration_minutes, numericality: { only_integer: true, greater_than: 0 }
  validates :max_capacity, presence: true
  validates :max_capacity, numericality: { only_integer: true, greater_than: 0 }

  belongs_to :company
end
