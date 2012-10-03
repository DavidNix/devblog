module DevblogExtensions
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

	CONTACT_DELIVERY_TO_EMAIL = "change-me-in-devblogextensionsy@example.com"

	WEBSITE_NAME = "DevBlog"

	WEBSITE_URL = "Devblog.com"

	AUTHOR_NAME = "David Nix"

end


class Time
	def self.random_date(years_back=5)
			year = Time.now.year - rand(years_back)
			month = rand(12) + 1
			# account for 28 days in Feb, not caring about leap years
			day = month == 2 ? rand(28) + 1 : rand(30) + 1
			Time.local(year, month, day)
	end
end

def devblog_rand(int=0)
	rand(int)+1
end