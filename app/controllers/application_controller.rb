class ApplicationController < ActionController::Base
  protect_from_forgery

  # overriding Devise path
  def after_sign_in_path_for(resource)
  	posts_path
  end

end
