# for contact mailer
# source:  http://matharvard.ca/posts/2011/aug/22/contact-form-in-rails-3/
class Message
	include ActiveModel::Validations
	include ActiveModel::Conversion
	extend ActiveModel::Naming

	HUMANIZED_ATTRIBUTES = {
    	body: "Message",
    	email: "Email address"
  	}
	def self.human_attribute_name(attr, options={})
	   HUMANIZED_ATTRIBUTES[attr.to_sym] || super
	end

	#  Objective is a hidden field and used to determine if certain validations should run
	attr_accessor :attributes, :name, :email, :body, :objective

	validates :email, :body, :name, presence: true
	validates :email, format: { with: DevblogExtensions::VALID_EMAIL_REGEX, message: "does not appear to be valid" }, unless: "email.blank?"

	def initialize(attributes = {})
		if not attributes.nil?
	    	attributes.each do |name, value|
	      		send("#{name}=", value)
	    	end
	    end
	    @attributes = attributes
  	end

	def persisted?
		false
	end

end