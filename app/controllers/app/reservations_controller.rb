module App
  class ReservationsController < BaseController
    before_action :set_activity, only: %i[ new create ]
    before_action :set_reservation, only: %i[ show destroy ]
    before_action :protect_activity, only: %i[ new create ]

    def index
      @reservations = authorize reservations
    end

    def show
      @event = Event.new(activity: @reservation.activity, starts_at: @reservation.starts_at).decorate
    end

    def new
      @reservation = authorize Current.customer.reservations.new(reservation_params)
      @event = Event.new(activity: @activity, starts_at: @reservation.starts_at).decorate

      render :form
    end

    def create
      @reservation = authorize Current.customer.reservations.new(reservation_params)
      @reservation.save!

      @event = Event.new(activity: @activity, starts_at: @reservation.starts_at)

      flash.now.notice = notice_message(model: Reservation.model_name.human)
    end

    def destroy
      @reservation.destroy!

      flash.now.notice = notice_message(model: Reservation.model_name.human)
    end

    private

    def reservations
      policy_scope(Current.customer.reservations).from_company(Current.company).future
    end
    helper_method :reservations

    def set_activity
      @activity = policy_scope(Current.company.activities).find(params[:activity_id])
    end

    def set_reservation
      @reservation = authorize Current.customer.reservations.find(params[:id])
    end

    def reservation_params
      params.require(:reservation).permit(:starts_at).with_defaults(activity: @activity)
    end

    def protect_activity
      head :no_content if Current.customer.reservations.exists?(reservation_params)
    end
  end
end
