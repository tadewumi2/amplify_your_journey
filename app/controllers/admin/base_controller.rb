class Admin::BaseController < ApplicationController
  before_action :require_admin
  layout 'admin'

  private

  def require_admin
    unless current_user&.admin?
      flash[:alert] = "Access denied"
      redirect_to root_path
    end
  end
end