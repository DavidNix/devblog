class ApplicationController < ActionController::Base
  protect_from_forgery

  # determine which layout to use
  layout :app_or_admin

  # custom error handling
  unless Rails.env.development?
    rescue_from Exception, with: lambda { |exception| render_error 500, exception }
    rescue_from ActionController::RoutingError, ActionController::UnknownController, ::AbstractController::ActionNotFound, ActiveRecord::RecordNotFound, with: lambda { |exception| render_error 404, exception }
  end

  # overriding Devise
  def after_sign_in_path_for(resource)
  	posts_url
  end

  private
  # returns the appropriate layout
  def app_or_admin
  	if is_blog_admin_controller?
  		"blog_admin/admin"
  	else
  		"application"
  	end

  end

  # in the future, logic may need to be changed if you want to use Devise for other purposes, like users
  def is_blog_admin_controller?
  	# add specific controllers here
  	blog_admin_controllers = %w{posts devise admin}
  	blog_admin_controllers.each do |controller|
  		if self.class.to_s =~ /#{controller}/i
  			return true
  		end
  	end

  	return false

  end

  def render_error(status, exception)
    # TO DO: Mailer to email the exception
    respond_to do |format|
      format.html { render template: "error/error_#{status}", layout: 'layouts/application', status: status }
      format.all { render nothing: true, status: status }
    end
  end

end
