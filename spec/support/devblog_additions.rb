include ApplicationHelper
include SitemapHelper

ADMIN_STYLESHEET_XPATH = "//html/head/link[@href='/assets/blog_admin.css' and @rel='stylesheet']"
APP_STYLESHEET_XPATH = "//html/head/link[@href='/assets/application.css' and @rel='stylesheet']"
RSS_XPATH = "//html/head/link[@href='#{DevblogExtensions::FEED_URL}' and @rel='alternate' and @type='application/rss+xml']"
GOOGLE_ANALYTICS_CONTENT = "var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;"