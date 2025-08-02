class Order < ApplicationRecord
  belongs_to :user
  has_many :order_items, dependent: :destroy
  has_many :products, through: :order_items

  validates :status, presence: true
  validates :total_price, presence: true, numericality: { greater_than: 0 }

  enum status: { pending: 'pending', processing: 'processing', shipped: 'shipped', delivered: 'delivered', cancelled: 'cancelled' }

  before_create :calculate_total

  private

  def calculate_total
    self.total_price = order_items.sum { |item| item.quantity * item.unit_price }
  end
end