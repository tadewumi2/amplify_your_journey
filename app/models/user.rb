class User < ApplicationRecord
  has_secure_password

  has_many :orders, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :bookings, dependent: :destroy

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, length: { minimum: 6 }, if: -> { new_record? || !password.nil? }

  CANADIAN_PROVINCES = {
    'AB' => 'Alberta',
    'BC' => 'British Columbia',
    'MB' => 'Manitoba',
    'NB' => 'New Brunswick',
    'NL' => 'Newfoundland and Labrador',
    'NS' => 'Nova Scotia',
    'ON' => 'Ontario',
    'PE' => 'Prince Edward Island',
    'QC' => 'Quebec',
    'SK' => 'Saskatchewan',
    'NT' => 'Northwest Territories',
    'NU' => 'Nunavut',
    'YT' => 'Yukon'
  }.freeze

  def admin?
    email.in?(['admin@riseandresound.com', 'tosin@riseandresound.com'])
  end

  def full_address
    [address_line_1, address_line_2, city, province_name, postal_code].compact.join(', ')
  end

  def province_name
    CANADIAN_PROVINCES[province]
  end
end