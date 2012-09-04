module SitemapHelper

	def w3c_time(time=Time.now)
		time.strftime("%F")
	end

end
