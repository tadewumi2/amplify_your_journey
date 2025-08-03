class Admin::ProductsController < Admin::BaseController
  before_action :set_product, only: [:show, :edit, :update, :destroy]

  def index
    @products = Product.includes(:category, :prices, image_attachment: :blob)

    # Apply search filter if present
    if params[:search].present?
      @products = @products.search(params[:search])
    end

    # Apply category filter if present
    if params[:category_id].present?
      @products = @products.where(category_id: params[:category_id])
    end

    @products = @products.order(:name)
    @categories = Category.all
  end

  def show
    # @product is set by before_action
  end

  def new
    @product = Product.new
    @categories = Category.all
  end

  def create
    @product = Product.new(product_params)

    if @product.save
      # Create initial price if provided
      if params[:price].present?
        @product.prices.create!(
          price: params[:price],
          start_date: Time.current
        )
      end
      flash[:notice] = "Product created successfully!"
      redirect_to admin_products_path
    else
      @categories = Category.all
      render :new
    end
  end

  def edit
    @categories = Category.all
  end

  def update
    # Handle image removal first
    if params[:remove_image] == "1"
      @product.image.purge if @product.image.attached?
      flash[:notice] = "Image removed successfully!"
      redirect_to edit_admin_product_path(@product)
      return
    end

    if @product.update(product_params)
      # Update price if changed
      if params[:price].present?
        current_price = @product.prices.where('end_date IS NULL').last
        if current_price.nil? || current_price.price != params[:price].to_f
          # End current price
          current_price&.update!(end_date: Time.current)
          # Create new price
          @product.prices.create!(
            price: params[:price],
            start_date: Time.current
          )
        end
      end
      flash[:notice] = "Product updated successfully!"
      redirect_to admin_product_path(@product)
    else
      @categories = Category.all
      render :edit
    end
  end

  def destroy
    puts "=== DESTROY ACTION STARTED ==="
    puts "Product: #{@product.inspect}"

    product_name = @product.name
    product_id = @product.id

    begin
      # Check dependencies and delete them first
      @product.order_items.destroy_all if @product.order_items.any?
      @product.reviews.destroy_all if @product.reviews.any?
      @product.prices.destroy_all if @product.prices.any?

      # Delete the product
      result = @product.destroy

      if result
        puts "=== PRODUCT DELETED SUCCESSFULLY ==="
        flash[:notice] = "Product '#{product_name}' was successfully deleted!"
      else
        puts "=== PRODUCT DELETION FAILED ==="
        puts "Errors: #{@product.errors.full_messages}"
        flash[:alert] = "Failed to delete product: #{@product.errors.full_messages.join(', ')}"
      end

    rescue => e
      puts "=== EXCEPTION DURING DELETION ==="
      puts "Error: #{e.message}"
      puts e.backtrace
      flash[:alert] = "Error deleting product: #{e.message}"
    end

    puts "=== REDIRECTING TO INDEX ==="
    redirect_to admin_products_path
  end

  private

  def set_product
    @product = Product.find(params[:id])
    puts "=== SET_PRODUCT: Found product #{@product.id} - #{@product.name} ==="
  rescue ActiveRecord::RecordNotFound
    puts "=== SET_PRODUCT: Product not found ==="
    flash[:alert] = "Product not found"
    redirect_to admin_products_path
  end

  def product_params
    params.require(:product).permit(:name, :description, :stock_quantity, :category_id, :image, :image_url)
  end
end