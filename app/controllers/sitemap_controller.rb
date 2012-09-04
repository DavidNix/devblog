class SitemapController < ApplicationController
	def index
		# Although unlikely, Google has a limit of 50000 links
		@articles = Post.published.limit(49500)

		respond_to do |format|
			format.xml { render layout: false }
		end
	end
end
