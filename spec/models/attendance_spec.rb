# == Schema Information
#
# Table name: attendances
#
#  id          :bigint           not null, primary key
#  attended_at :datetime         not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  company_id  :bigint           not null
#  customer_id :bigint           not null
#
# Indexes
#
#  idx_on_attended_at_company_id_customer_id_c1abd4461b  (attended_at,company_id,customer_id) UNIQUE
#  index_attendances_on_company_id                       (company_id)
#  index_attendances_on_customer_id                      (customer_id)
#
# Foreign Keys
#
#  fk_rails_...  (company_id => companies.id)
#  fk_rails_...  (customer_id => customers.id)
#
require 'rails_helper'

RSpec.describe Attendance, type: :model do
  context 'validations' do
    it { should validate_presence_of(:attended_at) }
  end

  context 'relationships' do
    it { should belong_to(:company) }
    it { should belong_to(:customer) }
  end
end
