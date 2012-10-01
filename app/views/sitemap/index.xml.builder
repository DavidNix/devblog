xml.instruct! :xml, :version => "1.0"
xml.urlset "xmlns" => "http://www.sitemaps.org/schemas/sitemap/0.9" do

  # home page
  xml.url do
  	xml.loc root_url
  	xml.lastmod w3c_time # defined in helper
  	xml.changefreq "daily"
  	xml.priority "1.0"
  end

  # products page
  xml.url do
    xml.loc products_url
    xml.lastmod w3c_time # defined in helper
    xml.changefreq "weekly"
    xml.priority "0.8"
  end

  # about page
  xml.url do
  	xml.loc about_url
  	xml.lastmod w3c_time
  	xml.changefreq "monthly"
  	xml.priority "0.7"
  end

  # contact page
  xml.url do
  	xml.loc contact_url
  	xml.lastmod w3c_time
  	xml.changefreq "monthly"
  	xml.priority "0.7"
  end

  # articles index
  xml.url do
    xml.loc articles_url
    xml.lastmod w3c_time(@articles.first.release_date)
    xml.changefreq "weekly"
    xml.priority "0.9"
  end

  # individual articles
  for article in @articles do
    xml.url do
      xml.loc article_url(article)
      xml.lastmod article_date(article) # defined in helper
      xml.changefreq "yearly"
      xml.priority "0.5"
    end
  end
end