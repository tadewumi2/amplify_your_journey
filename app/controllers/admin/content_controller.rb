class Admin::ContentController < Admin::BaseController
  def index
    @about_content = SiteContent.get_content('about')
    @contact_content = SiteContent.get_content('contact')
  end

  def edit_about
    @content = SiteContent.get_content('about')
  end

  def update_about
    SiteContent.update_content('about', {
      title: params[:title],
      content: params[:content]
    })

    flash[:notice] = "About page updated successfully!"
    redirect_to admin_content_path
  end

  def edit_contact
    @content = SiteContent.get_content('contact')
  end

  def update_contact
    contact_data = {
      address: params[:address],
      email: params[:email],
      phone: params[:phone],
      hours: params[:hours],
      additional_info: params[:additional_info]
    }

    SiteContent.update_content('contact', {
      title: params[:title],
      data: contact_data
    })

    flash[:notice] = "Contact page updated successfully!"
    redirect_to admin_content_path
  end
end