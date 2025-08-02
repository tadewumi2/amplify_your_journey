class OrdersController < ApplicationController
  before_action :require_login

  def new
    redirect_to cart_path if current_cart.empty?
    @order = Order.new
  end

  def create
    @order = current_user.orders.build(status: 'pending')

    # Create order items from cart
    current_cart.each do |product_id, quantity|
      product = Product.find(product_id)
      @order.order_items.build(
        product: product,
        quantity: quantity,
        unit_price: product.current_price
      )
    end

    if @order.save
      session[:cart] = {}
      flash[:notice] = "Order placed successfully!"
      redirect_to order_path(@order)
    else
      render :new
    end
  end

  def show
    @order = current_user.orders.includes(order_items: :product).find(params[:id])
  end

  def index
    @orders = current_user.orders.includes(order_items: :product).order(created_at: :desc)
  end
end