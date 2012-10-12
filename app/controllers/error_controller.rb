class ErrorController < ApplicationController
  def error_404
  	# for future use, taken from routes.rb: @not_found = params[:not_found]
  	# allows you to specify the page they were looking for that wasn't found
  end

  def error_500
  end
end
