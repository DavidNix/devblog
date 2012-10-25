module SocialIconsHelper

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
