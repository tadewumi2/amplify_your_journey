class CartController < ApplicationController
  def show
    @cart_items = []
    current_cart.each do |product_id, quantity|
      product = Product.find(product_id)
      @cart_items << {
        product: product,
        quantity: quantity,
        subtotal: product.current_price * quantity
      }
    end
    @total = @cart_items.sum { |item| item[:subtotal] }
  end

  def add
    product = Product.find(params[:product_id])
    quantity = params[:quantity].to_i || 1

    if product.in_stock?
      add_to_cart(product.id, quantity)
      flash[:notice] = "#{product.name} added to cart"
    else
      flash[:alert] = "Product is out of stock"
    end

    redirect_back(fallback_location: root_path)
  end

  def update
    session[:cart][params[:product_id]] = params[:quantity].to_i
    redirect_to cart_path
  end

  def remove
    session[:cart].delete(params[:product_id])
    redirect_to cart_path
  end

  def clear
    session[:cart] = {}
    redirect_to cart_path
  end
end
