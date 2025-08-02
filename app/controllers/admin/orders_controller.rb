class Admin::OrdersController < Admin::BaseController
  before_action :set_order, only: [:show, :update]

  def index
    @orders = Order.includes(:user, order_items: :product).order(created_at: :desc)
  end

  def show
  end

  def update
    if @order.update(order_params)
      flash[:notice] = "Order status updated successfully!"
    else
      flash[:alert] = "Error updating order status"
    end
    redirect_to admin_order_path(@order)
  end

  private

  def set_order
    @order = Order.find(params[:id])
  end

  def order_params
    params.require(:order).permit(:status)
  end
end
