module SitemapHelper

	def w3c_time(time=Time.now)
		time.strftime("%F")
	end

	# uses the most recent date, release_date vs. updated_at
	def article_date(article)
		published = article.release_date
		updated = article.updated_at
		if published >= updated
			return w3c_time(published)
		else
			return w3c_time(updated)
		end
	end

end
