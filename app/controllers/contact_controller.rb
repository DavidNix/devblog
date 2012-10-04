class ContactController < ApplicationController

	def new
	    @message = Message.new
	end

	def create
		@message = Message.new(params[:message])

		if @message.valid?
			ContactMailer.new_message(@message).deliver
			redirect_to(contact_path, :notice => "Your message was successfully sent.")
		else
			render :new
		end
	end

end
