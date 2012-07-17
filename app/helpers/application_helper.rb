module ApplicationHelper

# Returns the full title on a per-page basis.
# Set the base title here
  def full_title(page_title)
    base_title = "DevBlog"
    if page_title.empty?
      base_title
    else
      "#{base_title} | #{page_title}"
    end
  end

end
