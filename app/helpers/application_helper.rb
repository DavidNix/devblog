require 'devblog_extensions'

module ApplicationHelper

# Returns the full title on a per-page basis.
# Set the base title here
# Articles should not have the base title for SEO reasons.
  def full_title(page_title=nil, remove_base=false)
    base_title = DevblogExtensions::WEBSITE_NAME
    if remove_base == true
      "#{page_title}"
    elsif not page_title.nil? || page_title.empty?
      "#{page_title} | #{base_title}"
    else
      base_title
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

  # generate html from markdown
  def markdown(text)
    sanitize(BlueCloth::new(text).to_html)
  end

end
