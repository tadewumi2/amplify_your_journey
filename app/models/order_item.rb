class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :product

  validates :quantity, presence: true, numericality: { greater_than: 0 }
  validates :unit_price, presence: true, numericality: { greater_than: 0 }

  before_validation :set_unit_price

  private

  def set_unit_price
    self.unit_price = product.current_price if product
  end
end