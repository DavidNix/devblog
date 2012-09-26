class ApplicationController < ActionController::Base
  protect_from_forgery

  layout :app_or_admin

  # overriding Devise
  def after_sign_in_path_for(resource)
  	posts_url
  end

  private
  # returns the appropriate layout
  def app_or_admin
  	puts params[:controller].to_s.red
  	if is_blog_admin_controller?
  		"blog_admin/admin"
  	else
  		"application"
  	end

  end

  # in the future, logic may need to be changed if you want to use Devise for other purposes, like users
  def is_blog_admin_controller?
  	# add specific controllers here
  	blog_admin_controllers = %w{posts admin_registrations}
  	blog_admin_controllers.each do |controller|
  		param_controller = params[:controller]
  		if param_controller == controller || param_controller =~ /devise/i
  			return true
  		end
  	end

  	return false

  end

end
