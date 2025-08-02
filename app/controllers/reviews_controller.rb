class ReviewsController < ApplicationController
  before_action :require_login

  def create
    @product = Product.find(params[:product_id])
    @review = @product.reviews.build(review_params)
    @review.user = current_user

    if @review.save
      flash[:notice] = "Review added successfully!"
    else
      flash[:alert] = "Error adding review"
    end

    redirect_to product_path(@product)
  end

  private

  def review_params
    params.require(:review).permit(:rating, :comment)
  end
end
