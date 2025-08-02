class Booking < ApplicationRecord
  belongs_to :user, optional: true

  validates :name, presence: true
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :event_type, presence: true
  validates :organization, presence: true
  validates :preferred_date, presence: true

  enum event_type: {
    school_assembly: 'school_assembly',
    corporate_workshop: 'corporate_workshop',
    youth_event: 'youth_event',
    conference: 'conference',
    other: 'other'
  }
end