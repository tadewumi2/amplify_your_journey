class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:email])

    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:notice] = "Welcome back, #{user.name}!"

      # Redirect admin users to admin dashboard
      if user.admin?
        redirect_to admin_root_path
      else
        redirect_to root_path
      end
    else
      flash.now[:alert] = "Invalid email or password"
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    session[:cart] = nil
    flash[:notice] = "You have been logged out"
    redirect_to root_path
  end
end
