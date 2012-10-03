class ContactMailer < ActionMailer::Base
  default to: DevblogExtensions::CONTACT_DELIVERY_TO_EMAIL

	def new_message(message)
		@message = message
		subject = @message.subject.blank? ? "Form submitted from #{DevblogExtensions::WEBSITE_URL}." : @message.subject
		mail(subject: subject, from: @message.email )
	end

end
