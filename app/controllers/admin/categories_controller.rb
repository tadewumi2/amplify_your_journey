class Admin::CategoriesController < Admin::BaseController
  before_action :set_category, only: [:show, :edit, :update, :destroy]

  def index
    @categories = Category.includes(:products).order(:name)
  end

  def show
    # @category is set by before_action
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)

    if @category.save
      flash[:notice] = "Category created successfully!"
      redirect_to admin_categories_path
    else
      render :new
    end
  end

  def edit
    # @category is set by before_action
  end

  def update
    if @category.update(category_params)
      flash[:notice] = "Category updated successfully!"
      redirect_to admin_categories_path
    else
      render :edit
    end
  end

  def destroy
    puts "=== DESTROYING CATEGORY ==="
    puts "Category: #{@category.name}"
    puts "Category ID: #{@category.id}"
    puts "Products count: #{@category.products.count}"

    category_name = @category.name

    if @category.products.any?
      puts "=== CATEGORY HAS PRODUCTS - CANNOT DELETE ==="
      flash[:alert] = "Cannot delete category '#{category_name}' - it has #{@category.products.count} associated products. Please move or delete the products first."
    else
      begin
        puts "=== ATTEMPTING TO DELETE CATEGORY ==="
        result = @category.destroy

        if result
          puts "=== CATEGORY DELETED SUCCESSFULLY ==="
          flash[:notice] = "Category '#{category_name}' deleted successfully!"
        else
          puts "=== CATEGORY DELETION FAILED ==="
          puts "Errors: #{@category.errors.full_messages}"
          flash[:alert] = "Failed to delete category: #{@category.errors.full_messages.join(', ')}"
        end
      rescue => e
        puts "=== EXCEPTION DURING CATEGORY DELETION ==="
        puts "Error: #{e.message}"
        puts e.backtrace
        flash[:alert] = "Error deleting category: #{e.message}"
      end
    end

    puts "=== REDIRECTING TO CATEGORIES INDEX ==="
    redirect_to admin_categories_path
  end

  private

  def set_category
    @category = Category.find(params[:id])
    puts "=== SET_CATEGORY: Found category #{@category.id} - #{@category.name} ==="
  rescue ActiveRecord::RecordNotFound
    puts "=== SET_CATEGORY: Category not found ==="
    flash[:alert] = "Category not found"
    redirect_to admin_categories_path
  end

  def category_params
    params.require(:category).permit(:name)
  end
end