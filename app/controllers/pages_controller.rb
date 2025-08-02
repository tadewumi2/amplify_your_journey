class PagesController < ApplicationController
  def about
    @content = Rails.cache.fetch('site_content_about') || {
      title: "About Rise and Resound",
      content: "Founded in Winnipeg, Manitoba in 2022, Rise and Resound is a solo-run motivational brand with a mission to empower individuals through storytelling, personal development, and resilience training."
    }
  end

  def contact
    @content = Rails.cache.fetch('site_content_contact') || {
      title: "Contact Us",
      address: "Winnipeg, Manitoba, Canada",
      email: "tosin@riseandresound.com",
      phone: "",
      hours: "Monday - Friday: 9:00 AM - 5:00 PM"
    }
  end

  def contact_submit
    # Handle contact form submission
    ContactMailer.new_message(
      name: params[:name],
      email: params[:email],
      subject: params[:subject],
      message: params[:message]
    ).deliver_later

    flash[:notice] = "Thank you for your message! We'll get back to you soon."
    redirect_to contact_path
  end
end
