class ApplicationController < ActionController::Base
  protect_from_forgery

  # overriding devise methods
  def after_sign_in_path_for(resource)
  	posts_path
  end

end
