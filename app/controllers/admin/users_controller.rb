class Admin::UsersController < Admin::BaseController
  def index
    @users = User.includes(:orders).order(:name)
  end

  def show
    @user = User.includes(orders: { order_items: :product }).find(params[:id])
  end
end