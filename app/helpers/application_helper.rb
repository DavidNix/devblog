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

  # generate social media icons
  # opts:  
      # size:  32 or 64 (refers to pixels), defaults to 32
      # shadow: true or false, defaults to true
      # name: rss, twitter, googleplus, etc. (look in social_icons.css.scss)
      # new_window: true or false (i.e. target = "_blank")
      # href:  self explanatory
      # tooltips
        # tool_title: a string that will show when the user hovers over the icon
        # tool_placement: top, bottom, etc., see twitter bootstrap docs, defaults to bottom


  def sm_icon(opts={})
      opts[:size] ||= 32
      opts[:shadow] = true unless opts[:shadow] == false
      opts[:new_window] ||= false
      opts[:href] ||= '#'

      # tooltip opts
      rel = opts[:tool_title].nil? ? "" : "tooltip"
      opts[:tool_placement] ||= "bottom"

      return content_tag(:p, "Missing social icon name.") unless opts[:name]

      base_class = "sm_#{opts[:size]}_icon"
      icon_class = "sm_#{opts[:size]}_#{opts[:name]}"
      shadow_class = (opts[:shadow] == true ? "sm_shadow" : "")

      content_tag(:a, 
                  content_tag(:span),
                  class: "#{base_class} #{icon_class} #{shadow_class}",
                  href: opts[:href],
                  rel: rel,
                  title: opts[:tool_title],
                  :'data-placement' => opts[:tool_placement]
                  )

  end 

end
