require 'devblog_extensions'

module ApplicationHelper

# Returns the full title on a per-page basis.
# Set the base title here
  def full_title(page_title)
    base_title = DevblogExtensions::WEBSITE_NAME
    if page_title.empty?
      base_title
    else
      "#{base_title} | #{page_title}"
    end
  end

  # for setting the class of the active nav link
  # you can pass in either a string or array
  def is_active?(path)
  	paths = []
  	if not path.is_a?(Array)
  		paths << path
  	else
  		paths = path
  	end
  	paths.each { |p| return "active" if current_page?(p) }
  end

  # gnerate html from markdown

  def markdown(text)
    sanitize(BlueCloth::new(text).to_html)
  end

end
