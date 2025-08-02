class BookingsController < ApplicationController
  def new
    @booking = Booking.new
  end

  def create
    @booking = Booking.new(booking_params)
    @booking.user = current_user if logged_in?

    if @booking.save
      flash[:notice] = "Speaking request submitted successfully! We'll contact you soon."
      redirect_to root_path
    else
      render :new
    end
  end

  private

  def booking_params
    params.require(:booking).permit(:name, :email, :event_type, :organization, :preferred_date, :notes)
  end
end
