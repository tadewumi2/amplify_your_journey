class Admin::ContentController < Admin::BaseController
  def index
    @about_content = Rails.cache.fetch('site_content_about') || default_about_content
    @contact_content = Rails.cache.fetch('site_content_contact') || default_contact_content
  end

  def update_about
    Rails.cache.write('site_content_about', params[:content])
    flash[:notice] = "About page updated successfully!"
    redirect_to admin_content_path
  end

  def update_contact
    Rails.cache.write('site_content_contact', params[:content])
    flash[:notice] = "Contact page updated successfully!"
    redirect_to admin_content_path
  end

  private

  def default_about_content
    {
      title: "Amplify the Journey",
      content: "Founded in Winnipeg, Manitoba in 2022, Rise and Resound is a solo-run motivational brand with a mission to empower individuals through storytelling, personal development, and resilience training."
    }
  end

  def default_contact_content
    {
      title: "Contact Us",
      address: "Winnipeg, Manitoba, Canada",
      email: "tosin@riseandresound.com",
      phone: "",
      hours: "Monday - Friday: 9:00 AM - 5:00 PM"
    }
  end
end
