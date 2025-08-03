class PagesController < ApplicationController
  def about
    @content = SiteContent.get_content('about')
  end

  def contact
    @content = SiteContent.get_content('contact')
  end

  def contact_submit
    # Handle contact form submission
    flash[:notice] = "Thank you for your message! We'll get back to you soon."
    redirect_to contact_path
  end
end