atom_feed do |feed|
	feed.title DevblogExtensions::WEBSITE_NAME
	feed.updated @articles.first.release_date

	Post.published.each do |article|
		feed.entry article, published: article.release_date, url: article_url(article) do |entry|
			entry.title article.title
			entry.content(markdown(article.content), type: 'html')
			entry.summary article.teaser
			entry.author do |author|
				author.name DevblogExtensions::AUTHOR_NAME # need to put this in DevBlogExtensions
			end
		end
	end
end