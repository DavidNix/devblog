class ContactController < ApplicationController

	def new
	    @message = Message.new
	end

	def create
		@message = Message.new(params[:message])

		# email_only partial in contact view captures the previous action and controller
		if params[:email_only] == "true"
			if @message.valid?
				ContactMailer.new_message(@message).deliver
				redirect_to(:back, :notice => "Your message was successfully sent.")
			else
				render params[:prev_controller] + "/" + params[:prev_action]
			end
		else
			if @message.valid?
				ContactMailer.new_message(@message).deliver
				redirect_to(contact_path, :notice => "Your message was successfully sent.")
			else
				render :new
			end
		end
	end

end
