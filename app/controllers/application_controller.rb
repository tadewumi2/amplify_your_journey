class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :current_user
  helper_method :current_user, :logged_in?, :current_cart

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
    !!current_user
  end

  def require_login
    unless logged_in?
      flash[:alert] = "You must be logged in to access this page"
      redirect_to login_path
    end
  end

  def require_admin
    unless current_user&.admin?
      flash[:alert] = "Access denied"
      redirect_to root_path
    end
  end

  def current_cart
    @current_cart ||= session[:cart] || {}
  end

  def add_to_cart(product_id, quantity = 1)
    session[:cart] ||= {}
    session[:cart][product_id.to_s] = (session[:cart][product_id.to_s] || 0) + quantity.to_i
  end

  def cart_total_items
    current_cart.values.sum
  end
  helper_method :cart_total_items
end
