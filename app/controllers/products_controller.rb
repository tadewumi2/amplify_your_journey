class ProductsController < ApplicationController
  before_action :set_categories, only: [:index, :search]

  def index
    @products = Product.includes(:category, :prices, image_attachment: :blob).available
    @products = @products.by_category(params[:category_id]) if params[:category_id].present?
    @products = @products.search(params[:search]) if params[:search].present?

    # Apply filters
    case params[:filter]
    when 'on_sale'
      @products = @products.on_sale
    when 'new'
      @products = @products.new_products
    when 'recently_updated'
      @products = @products.recently_updated
    end

    # Pagination (simple version - 9 products per page)
    @page = (params[:page] || 1).to_i
    @per_page = 9
    @total_products = @products.count
    @products = @products.offset((@page - 1) * @per_page).limit(@per_page)
    @total_pages = (@total_products.to_f / @per_page).ceil

    @current_category = Category.find(params[:category_id]) if params[:category_id].present?
  end

  def show
    @product = Product.includes(:category, :prices, reviews: :user, image_attachment: :blob).find(params[:id])
    @review = Review.new
  end

  def search
    @products = Product.includes(:category, :prices).available
    @products = @products.search(params[:q]) if params[:q].present?
    @products = @products.by_category(params[:category_id]) if params[:category_id].present?

    render json: {
      products: @products.map do |product|
        {
          id: product.id,
          name: product.name,
          price: product.current_price,
          category: product.category.name,
          url: product_path(product)
        }
      end
    }
  end

  private

  def set_categories
    @categories = Category.includes(:products).where(products: { id: Product.available.select(:id) }).distinct
  end
end
