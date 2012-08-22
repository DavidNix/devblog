class ContactMailer < ActionMailer::Base
  default to: DevblogExtensions::CONTACT_DELIVERY_TO_EMAIL

	def new_message(message)
		@message = message
		subject = "Contact form submitted for CHANGE-ME.com"
		mail(subject: subject, from: "#{@message.name} <#{@message.email}>" )
	end

end
