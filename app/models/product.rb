class Product < ApplicationRecord
  belongs_to :category
  has_many :order_items, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :prices, dependent: :destroy
  has_one_attached :image

  validates :name, presence: true
  validates :description, presence: true
  validates :stock_quantity, presence: true, numericality: { greater_than_or_equal_to: 0 }

  scope :available, -> { where('stock_quantity > 0') }
  scope :by_category, ->(category_id) { where(category_id: category_id) if category_id.present? }

  # Fixed search scope for SQLite compatibility
  scope :search, ->(query) do
    if query.present?
      joins(:category).where(
        'LOWER(products.name) LIKE ? OR LOWER(products.description) LIKE ? OR LOWER(categories.name) LIKE ?',
        "%#{query.downcase}%", "%#{query.downcase}%", "%#{query.downcase}%"
      )
    end
  end

  scope :on_sale, -> { joins(:prices).where('prices.end_date IS NOT NULL') }
  scope :recently_updated, -> { where('updated_at > ?', 7.days.ago) }
  scope :new_products, -> { where('created_at > ?', 30.days.ago) }

  def current_price
    prices.where('start_date <= ? AND (end_date IS NULL OR end_date >= ?)', Time.current, Time.current).last&.price || 0
  end

  def in_stock?
    stock_quantity > 0
  end

  def on_sale?
    prices.where('end_date IS NOT NULL AND start_date <= ? AND end_date >= ?', Time.current, Time.current).exists?
  end

  def is_new?
    created_at > 30.days.ago
  end

  def recently_updated?
    updated_at > 7.days.ago
  end

  def average_rating
    reviews.average(:rating)&.round(1) || 0
  end

  def display_image
    if image.attached?
      image
    elsif image_url.present?
      image_url
    else
      nil
    end
  end
end