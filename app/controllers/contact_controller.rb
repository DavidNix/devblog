class ContactController < ApplicationController

	def new
	    @message = Message.new
	end

	def create
		@message = Message.new(params[:message])
		
		if @message.valid?
			ContactMailer.new_message(@message).deliver
			redirect_to(contact_url, :notice => "Your message was successfully sent.")
		else
			render :new
		end
	end

	def create_email_only
		@message = Message.new(params[:message])
		origin_url = params[:origin_url]
		
		if @message.valid?
			ContactMailer.new_message(@message).deliver
			redirect_to(origin_url, :notice => "Thank you for submitting your email!")
		else
			flash[:error] = 'Unable to submit your email.  Was it blank or incorrectly typed?'
			redirect_to origin_url
		end
	end

end
