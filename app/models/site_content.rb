class SiteContent < ApplicationRecord
  validates :page_name, presence: true, uniqueness: true

  # Store additional data as JSON
  serialize :data, JSON

  def self.get_content(page_name)
    content = find_by(page_name: page_name)
    return content if content

    # Create default content if it doesn't exist
    case page_name
    when 'about'
      create_default_about
    when 'contact'
      create_default_contact
    else
      nil
    end
  end

  def self.update_content(page_name, attributes)
    content = find_or_initialize_by(page_name: page_name)
    content.update!(attributes)
    content
  end

  private

  def self.create_default_about
    create!(
      page_name: 'about',
      title: 'About Rise and Resound',
      content: 'Founded in Winnipeg, Manitoba in 2022, Rise and Resound is a solo-run motivational brand with a mission to empower individuals through storytelling, personal development, and resilience training.

We have grown organically through speaking engagements at schools, community events, and youth development programs. Our online store offers digital motivational products, coaching sessions, and branded merchandise to extend our reach and impact.',
      data: {}
    )
  end

  def self.create_default_contact
    create!(
      page_name: 'contact',
      title: 'Contact Us',
      content: '',
      data: {
        address: 'Winnipeg, Manitoba, Canada',
        email: 'tosin@riseandresound.com',
        phone: '(204) 555-0123',
        hours: 'Monday - Friday: 9:00 AM - 5:00 PM',
        additional_info: "We'd love to hear from you! Whether you're interested in booking a speaking engagement, have questions about our products, or just want to connect, don't hesitate to reach out."
      }
    )
  end
end
