class ContactMailer < ActionMailer::Base
  default to: DevblogExtensions::CONTACT_EMAIL_TO

	def new_message(message)
		@message = message
		subject = "Contact form submitted for CHANGE-ME.com"
		mail(subject: subject, from: "#{@message.name} <#{@message.email}>" )
	end

end
