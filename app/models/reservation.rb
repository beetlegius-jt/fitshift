# == Schema Information
#
# Table name: reservations
#
#  id          :bigint           not null, primary key
#  starts_at   :datetime         not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  activity_id :bigint           not null
#  customer_id :bigint           not null
#
# Indexes
#
#  idx_on_starts_at_customer_id_activity_id_c502fbaf1c  (starts_at,customer_id,activity_id) UNIQUE
#  index_reservations_on_activity_id                    (activity_id)
#  index_reservations_on_customer_id                    (customer_id)
#
# Foreign Keys
#
#  fk_rails_...  (activity_id => activities.id)
#  fk_rails_...  (customer_id => customers.id)
#
class Reservation < ApplicationRecord
  validates :starts_at, presence: true
  validates :starts_at, uniqueness: { scope: [ :customer_id, :activity_id ] }
  validate :activity_is_available, on: :create

  belongs_to :customer
  belongs_to :activity

  private

  def activity_is_available
    return unless starts_at && activity

    errors.add(:activity, :taken) unless activity.available_at?(starts_at)
  end
end
