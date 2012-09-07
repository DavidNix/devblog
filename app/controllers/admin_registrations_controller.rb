class AdminRegistrationsController < Devise::RegistrationsController
	
	# override create to allow for only 1 admin
	def new
		if Admin.limit_reached?
			flash[:error] = 'Unable to create new admin.'
			redirect_to root_url
		else
			super
		end
	end
end
