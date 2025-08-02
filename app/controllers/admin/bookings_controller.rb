class Admin::BookingsController < Admin::BaseController
  def index
    @bookings = Booking.includes(:user).order(created_at: :desc)
  end

  def show
    @booking = Booking.find(params[:id])
  end
end