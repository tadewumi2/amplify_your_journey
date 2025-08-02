class Admin::DashboardController < Admin::BaseController
  def index
    @total_products = Product.count
    @total_orders = Order.count
    @total_users = User.count
    @pending_orders = Order.where(status: 'pending').count
    @recent_orders = Order.includes(:user, order_items: :product).order(created_at: :desc).limit(5)
    @recent_bookings = Booking.order(created_at: :desc).limit(5)
  end
end