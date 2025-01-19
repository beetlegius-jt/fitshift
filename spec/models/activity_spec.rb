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
require 'rails_helper'

RSpec.describe Activity, type: :model do
  context 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:duration_minutes) }
    it { should validate_presence_of(:max_capacity) }
    it { should validate_numericality_of(:duration_minutes).is_greater_than(0).only_integer }
    it { should validate_numericality_of(:max_capacity).is_greater_than(0).only_integer }
  end

  context 'relationships' do
    it { should belong_to(:company) }
  end
end
