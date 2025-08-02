class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = "Account created successfully! Welcome to Rise and Resound!"
      redirect_to root_path
    else
      flash.now[:alert] = "Please fix the errors below"
      render :new
    end
  end

  def show
    @user = current_user
    @recent_orders = @user.orders.includes(order_items: :product).order(created_at: :desc).limit(5)
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user

    if @user.update(user_update_params)
      flash[:notice] = "Profile updated successfully!"
      redirect_to user_path(@user)
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation,
                                 :address_line_1, :address_line_2, :city, :province, :postal_code, :phone)
  end

  def user_update_params
    params.require(:user).permit(:name, :email, :address_line_1, :address_line_2,
                                 :city, :province, :postal_code, :phone)
  end
end
