module App
  class ReservationComponent < ViewComponent::Base
    def initialize(reservation:)
      @reservation = reservation.decorate
    end
  end
end
