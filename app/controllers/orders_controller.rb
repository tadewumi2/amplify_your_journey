class OrdersController < ApplicationController
  before_action :require_login

  def index
    @orders = current_user.orders.includes(order_items: :product).order(created_at: :desc)
  end

  def show
    @order = current_user.orders.includes(order_items: :product).find(params[:id])
  end

  def new
    # Redirect if cart is empty
    if current_cart.empty?
      flash[:alert] = "Your cart is empty. Add some products before checking out."
      redirect_to products_path
      return
    end

    @order = Order.new
    @cart_items = get_cart_items
    @subtotal = calculate_subtotal
    @tax = calculate_tax(@subtotal)
    @total = @subtotal + @tax
  end

  def create
    # Validate cart is not empty
    if current_cart.empty?
      flash[:alert] = "Your cart is empty."
      redirect_to cart_path
      return
    end

    # Calculate totals
    cart_items = get_cart_items
    subtotal = calculate_subtotal
    tax = calculate_tax(subtotal)
    total = subtotal + tax

    # Create the order
    @order = current_user.orders.build(
      status: 'pending',
      total_price: total
    )

    begin
      Order.transaction do
        # Save the order
        @order.save!

        # Create order items from cart
        cart_items.each do |item|
          @order.order_items.create!(
            product: item[:product],
            quantity: item[:quantity],
            unit_price: item[:product].current_price
          )

          # Update product stock
          product = item[:product]
          new_stock = product.stock_quantity - item[:quantity]

          if new_stock < 0
            raise ActiveRecord::Rollback, "Insufficient stock for #{product.name}"
          end

          product.update!(stock_quantity: new_stock)
        end

        # Clear the cart after successful order
        session[:cart] = {}

        # Set success flash message
        flash[:notice] = "Order placed successfully! Your order number is ##{@order.id}."

        # Redirect to order confirmation page
        redirect_to order_path(@order)
      end

    rescue => e
      Rails.logger.error "Order creation failed: #{e.message}"
      flash[:alert] = "There was an error processing your order: #{e.message}"
      redirect_to new_order_path
    end
  end

  private

  def get_cart_items
    cart_items = []
    current_cart.each do |product_id, quantity|
      product = Product.find(product_id)
      cart_items << {
        product: product,
        quantity: quantity,
        subtotal: product.current_price * quantity
      }
    end
    cart_items
  end

  def calculate_subtotal
    get_cart_items.sum { |item| item[:subtotal] }
  end

  def calculate_tax(subtotal)
    # Default 13% tax (can be made configurable later)
    (subtotal * 0.13).round(2)
  end
end