class ContactMailer < ActionMailer::Base
  default to: "change-me-in-mailers-directory@example.com"

	def new_message(message)
		@message = message
		subject = "Contact form submitted for CHANGE-ME.com"
		mail(subject: subject, from: "#{@message.name} <#{@message.email}>" )
	end

end
