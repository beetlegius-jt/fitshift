class ReservationDecorator < ApplicationDecorator
  delegate_all

  def start_time
    h.l starts_at, format: :hour
  end
end
