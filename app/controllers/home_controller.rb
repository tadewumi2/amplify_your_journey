class HomeController < ApplicationController
  def index
    @featured_products = Product.includes(:category, :prices).available.limit(6)
    @categories = Category.includes(:products).where(products: { id: Product.available.select(:id) })
  end
end